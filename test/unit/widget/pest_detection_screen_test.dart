import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crop_advisory/features/pest_detection/screens/pest_detection_screen.dart';
import 'package:crop_advisory/providers/pest_detection_provider.dart';
import 'package:crop_advisory/services/tflite_service.dart';

void main() {
  group('PestDetectionScreen', () {
    testWidgets('renders app bar with title', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestApp());

      expect(find.text('Pest Detection'), findsOneWidget);
    });

    testWidgets('shows image picker placeholder initially', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestApp());

      expect(find.text('Tap to capture or select plant image'), findsOneWidget);
      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    });

    testWidgets('shows model error banner when modelLoadError is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(state: const PestDetectionState(modelLoadError: true)),
      );

      expect(
        find.text('On-device model unavailable. Cloud analysis only.'),
        findsOneWidget,
      );
    });

    testWidgets('shows tflite result card when result exists', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          state: PestDetectionState(
            tfliteResult: const TfliteResult(
              label: 'Tomato___Late_blight',
              confidence: 0.85,
            ),
          ),
        ),
      );

      expect(find.text('Quick Detection (On-Device)'), findsOneWidget);
      expect(find.text('Late blight (Tomato)'), findsOneWidget);
      expect(find.textContaining('85.0%'), findsOneWidget);
    });

    testWidgets('shows healthy result correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          state: const PestDetectionState(
            tfliteResult: TfliteResult(
              label: 'Tomato___healthy',
              confidence: 0.92,
            ),
          ),
        ),
      );

      expect(find.text('Healthy (Tomato)'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows cloud analysis button when tflite result exists but no gemini report', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          state: const PestDetectionState(
            tfliteResult: TfliteResult(
              label: 'Potato___Early_blight',
              confidence: 0.78,
            ),
          ),
        ),
      );

      expect(find.text('Get Detailed Analysis (Cloud)'), findsOneWidget);
    });

    testWidgets('shows gemini report when available', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          state: const PestDetectionState(
            geminiReport:
                'Detailed analysis: Early blight detected with moderate severity.',
          ),
        ),
      );

      expect(find.text('Detailed Report (Cloud)'), findsOneWidget);
      expect(find.text('Gemini Vision Analysis'), findsOneWidget);
      expect(find.textContaining('Early blight'), findsOneWidget);
    });

    testWidgets('shows error message when present', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildTestApp(
          state: const PestDetectionState(
            errorMessage: 'Cloud analysis failed. On-device result still available.',
          ),
        ),
      );

      expect(
        find.text('Cloud analysis failed. On-device result still available.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}

Widget _buildTestApp({PestDetectionState? state}) {
  return ProviderScope(
    overrides: [
      tfliteServiceProvider.overrideWith((ref) => _FakeTfliteService()),
      if (state != null)
        pestDetectionProvider.overrideWith((ref) {
          final notifier = _MockPestNotifier(ref);
          notifier.state = state;
          return notifier;
        }),
    ],
    child: MaterialApp(home: PestDetectionScreen()),
  );
}

/// A minimal mock notifier for widget tests
class _MockPestNotifier extends PestDetectionNotifier {
  _MockPestNotifier(Ref ref) : super(ref);

  // no-op overrides — we set state directly in the test
}

class _FakeTfliteService extends TfliteService {
  bool _loaded = false;

  @override
  bool get isLoaded => _loaded;

  @override
  Future<void> loadModel() async {
    _loaded = true;
  }

  @override
  void dispose() {
    _loaded = false;
  }
}