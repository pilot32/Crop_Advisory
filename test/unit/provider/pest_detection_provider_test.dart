import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crop_advisory/services/tflite_service.dart';
import 'package:crop_advisory/services/gemini_pest_service.dart';
import 'package:crop_advisory/providers/pest_detection_provider.dart';

// ── Mocks ──────────────────────────────────────────────────────────────

class MockTfliteService extends Mock implements TfliteService {}

class MockGeminiPestService extends Mock implements GeminiPestService {}

// ── Override helpers ───────────────────────────────────────────────────

final mockTfliteServiceProvider = Provider<TfliteService>((ref) {
  final mock = MockTfliteService();
  ref.onDispose(() {}); // no-op
  return mock;
});

final mockGeminiPestServiceProvider = Provider<GeminiPestService?>((ref) {
  return MockGeminiPestService();
});

final noGeminiProvider = Provider<GeminiPestService?>((ref) => null);

// Create a pestDetectionProvider override that skips _loadModel in constructor
final testPestDetectionProvider = StateNotifierProvider<PestDetectionNotifier, PestDetectionState>(
  (ref) => PestDetectionNotifier(ref),
);

void main() {
  setUpAll(() {
    registerFallbackValue(Uint8List(0));
  });

  late MockTfliteService mockTflite;
  late MockGeminiPestService mockGemini;
  late ProviderContainer container;

  final testImageBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]); // JPEG header

  setUp(() {
    mockTflite = MockTfliteService();
    mockGemini = MockGeminiPestService();

    container = ProviderContainer(
      overrides: [
        mockTfliteServiceProvider.overrideWithValue(mockTflite),
        mockGeminiPestServiceProvider.overrideWithValue(mockGemini),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('PestDetectionNotifier', () {
    group('analyzeWithTflite', () {
      test('emits tfliteResult on success', () async {
        // Arrange
        when(() => mockTflite.isLoaded).thenReturn(true);
        when(() => mockTflite.analyzeImage(imageBytes: any(named: 'imageBytes')))
            .thenAnswer((_) async => [
                  const MapEntry('Tomato___Late_blight', 0.85),
                  const MapEntry('Tomato___Early_blight', 0.10),
                  const MapEntry('Tomato___healthy', 0.05),
                ]);

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        // Act
        await notifier.analyzeWithTflite(testImageBytes);

        // Assert
        expect(notifier.state.tfliteResult, isNotNull);
        expect(notifier.state.tfliteResult!.label, equals('Tomato___Late_blight'));
        expect(notifier.state.tfliteResult!.confidence, equals(0.85));
        expect(notifier.state.isAnalyzing, isFalse);
        verify(() => mockTflite.analyzeImage(imageBytes: any(named: 'imageBytes'))).called(1);
      });

      test('sets error when model not loaded', () async {
        when(() => mockTflite.isLoaded).thenReturn(false);

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        await notifier.analyzeWithTflite(testImageBytes);

        expect(notifier.state.tfliteResult, isNull);
        expect(notifier.state.errorMessage, isNotNull);
        expect(notifier.state.isAnalyzing, isFalse);
      });

      test('sets error on inference failure', () async {
        when(() => mockTflite.isLoaded).thenReturn(true);
        when(() => mockTflite.analyzeImage(imageBytes: any(named: 'imageBytes')))
            .thenThrow(Exception('Inference failed'));

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        await notifier.analyzeWithTflite(testImageBytes);

        expect(notifier.state.tfliteResult, isNull);
        expect(notifier.state.errorMessage, isNotNull);
        expect(notifier.state.isAnalyzing, isFalse);
      });
    });

    group('analyzeWithGemini', () {
      test('emits geminiReport on success', () async {
        when(() => mockGemini.analyzeImage(
          imageBytes: any(named: 'imageBytes'),
          mimeType: any(named: 'mimeType'),
          language: any(named: 'language'),
        )).thenAnswer((_) async => 'Severe leaf blight detected. Use copper fungicide.');

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        await notifier.analyzeWithGemini(
          imageBytes: testImageBytes,
          mimeType: 'image/jpeg',
        );

        expect(notifier.state.geminiReport, isNotNull);
        expect(notifier.state.geminiReport, contains('leaf blight'));
        expect(notifier.state.isGeminiLoading, isFalse);
      });

      test('sets error when gemini service is null', () async {
        final notifier = TestPestDetectionNotifier(mockTflite, null);

        await notifier.analyzeWithGemini(imageBytes: testImageBytes);

        expect(notifier.state.errorMessage, isNotNull);
        expect(notifier.state.errorMessage, contains('not configured'));
        expect(notifier.state.geminiReport, isNull);
      });

      test('sets error on gemini API failure', () async {
        when(() => mockGemini.analyzeImage(
          imageBytes: any(named: 'imageBytes'),
          mimeType: any(named: 'mimeType'),
          language: any(named: 'language'),
        )).thenThrow(Exception('API_KEY_INVALID'));

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        await notifier.analyzeWithGemini(imageBytes: testImageBytes);

        expect(notifier.state.geminiReport, isNull);
        expect(notifier.state.errorMessage, contains('Invalid API key'));
        expect(notifier.state.isGeminiLoading, isFalse);
      });

      test('handles quota exceeded error', () async {
        when(() => mockGemini.analyzeImage(
          imageBytes: any(named: 'imageBytes'),
          mimeType: any(named: 'mimeType'),
          language: any(named: 'language'),
        )).thenThrow(Exception('QUOTA_EXCEEDED'));

        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        await notifier.analyzeWithGemini(imageBytes: testImageBytes);

        expect(notifier.state.errorMessage, contains('quota'));
        expect(notifier.state.isGeminiLoading, isFalse);
      });
    });

    group('reset', () {
      test('clears results but keeps isTfliteReady', () async {
        final notifier = TestPestDetectionNotifier(mockTflite, mockGemini);

        // Set some state first
        notifier.state = notifier.state.copyWith(
          isTfliteReady: true,
          tfliteResult: const TfliteResult(label: 'Test', confidence: 0.5),
          geminiReport: 'Report',
        );

        notifier.reset();

        expect(notifier.state.tfliteResult, isNull);
        expect(notifier.state.geminiReport, isNull);
        expect(notifier.state.errorMessage, isNull);
        expect(notifier.state.isTfliteReady, isTrue); // preserved
      });
    });
  });
}

// ── Test helper: Notifier that accepts mocks directly (no Riverpod needed) ──

class TestPestDetectionNotifier extends StateNotifier<PestDetectionState> {
  final TfliteService _tflite;
  final GeminiPestService? _gemini;

  TestPestDetectionNotifier(this._tflite, this._gemini)
      : super(const PestDetectionState());

  Future<void> analyzeWithTflite(Uint8List imageBytes) async {
    state = state.copyWith(isAnalyzing: true, errorMessage: null, tfliteResult: null);
    try {
      if (!_tflite.isLoaded) throw Exception('Model not loaded');
      final results = await _tflite.analyzeImage(imageBytes: imageBytes);
      if (results.isNotEmpty) {
        final top = results.first;
        state = state.copyWith(
          tfliteResult: TfliteResult(label: top.key, confidence: top.value),
          isAnalyzing: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isAnalyzing: false, errorMessage: 'On-device analysis failed: $e');
    }
  }

  Future<void> analyzeWithGemini({
    required Uint8List imageBytes,
    String mimeType = 'image/jpeg',
    String language = 'english',
  }) async {
    if (_gemini == null) {
      state = state.copyWith(errorMessage: 'Gemini not configured. Add your API key in Settings.');
      return;
    }
    state = state.copyWith(isGeminiLoading: true, geminiReport: null, errorMessage: null);
    try {
      final report = await _gemini!.analyzeImage(
        imageBytes: imageBytes,
        mimeType: mimeType,
        language: language,
      );
      state = state.copyWith(geminiReport: report, isGeminiLoading: false);
    } catch (e) {
      final msg = e.toString();
      String friendly;
      if (msg.contains('API_KEY')) friendly = 'Invalid API key. Check Settings.';
      else if (msg.contains('QUOTA')) friendly = 'API quota exceeded. Try again later.';
      else if (msg.contains('NETWORK')) friendly = 'No internet connection.';
      else if (msg.contains('SAFETY')) friendly = 'Image blocked by safety filter.';
      else friendly = 'Something went wrong. Try again.';
      state = state.copyWith(isGeminiLoading: false, errorMessage: 'Cloud analysis failed: $friendly');
    }
  }

  @override
  void reset() {
    state = PestDetectionState(isTfliteReady: state.isTfliteReady);
  }
}