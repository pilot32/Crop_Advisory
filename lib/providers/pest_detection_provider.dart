import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img_lib;
import 'package:logger/logger.dart';
import '../services/tflite_service.dart';
import '../services/gemini_pest_service.dart';

final _logger = Logger();

// ─── Data models ────────────────────────────────────────────────────

class TfliteResult {
  final String label;
  final double confidence;
  const TfliteResult({required this.label, required this.confidence});

  bool get isHealthy => label.toLowerCase().contains('healthy');

  String get displayName {
    // "Tomato___Late_blight" → "Late Blight (Tomato)"
    final parts = label.split('___');
    if (parts.length == 2) {
      final crop = parts[0].replaceAll('_', ' ');
      final disease = parts[1].replaceAll('_', ' ').trim();
      if (isHealthy) return 'Healthy ($crop)';
      return '$disease ($crop)';
    }
    return label.replaceAll('_', ' ');
  }
}

class PestDetectionState {
  final bool isAnalyzing;
  final bool isTfliteReady;
  final TfliteResult? tfliteResult;
  final String? geminiReport;
  final bool isGeminiLoading;
  final String? errorMessage;
  final bool modelLoadError;

  const PestDetectionState({
    this.isAnalyzing = false,
    this.isTfliteReady = false,
    this.tfliteResult,
    this.geminiReport,
    this.isGeminiLoading = false,
    this.errorMessage,
    this.modelLoadError = false,
  });

  PestDetectionState copyWith({
    bool? isAnalyzing,
    bool? isTfliteReady,
    TfliteResult? tfliteResult,
    String? geminiReport,
    bool? isGeminiLoading,
    String? errorMessage,
    bool? modelLoadError,
  }) {
    return PestDetectionState(
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      isTfliteReady: isTfliteReady ?? this.isTfliteReady,
      tfliteResult: tfliteResult ?? this.tfliteResult,
      geminiReport: geminiReport ?? this.geminiReport,
      isGeminiLoading: isGeminiLoading ?? this.isGeminiLoading,
      errorMessage: errorMessage,
      modelLoadError: modelLoadError ?? this.modelLoadError,
    );
  }
}

// ─── Providers ──────────────────────────────────────────────────────

final tfliteServiceProvider = Provider<TfliteService>((ref) {
  final service = TfliteService();
  ref.onDispose(() => service.dispose());
  return service;
});

final geminiPestServiceProvider = Provider<GeminiPestService>((ref) {
  return GeminiPestService();
});

final pestDetectionProvider =
    StateNotifierProvider<PestDetectionNotifier, PestDetectionState>(
  (ref) => PestDetectionNotifier(ref),
);

// ─── Notifier ───────────────────────────────────────────────────────

class PestDetectionNotifier extends StateNotifier<PestDetectionState> {
  final Ref _ref;

  PestDetectionNotifier(this._ref) : super(const PestDetectionState()) {
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      final tflite = _ref.read(tfliteServiceProvider);
      await tflite.loadModel();
      state = state.copyWith(isTfliteReady: true);
      _logger.i('TFLite model loaded successfully');
    } catch (e) {
      _logger.e('Failed to load TFLite model: $e');
      state = state.copyWith(
        modelLoadError: true,
        errorMessage: 'On-device model failed to load. Cloud analysis still available.',
      );
    }
  }

  /// Run on-device TFLite analysis (instant)
  Future<void> analyzeWithTflite(Uint8List imageBytes) async {
    state = state.copyWith(
      isAnalyzing: true,
      errorMessage: null,
      tfliteResult: null,
      geminiReport: null,
    );

    try {
      final tflite = _ref.read(tfliteServiceProvider);
      if (!tflite.isLoaded) {
        throw Exception('Model not loaded');
      }

      final results = await tflite.analyzeImage(imageBytes: imageBytes);
      if (results.isNotEmpty) {
        final top = results.first;
        state = state.copyWith(
          tfliteResult: TfliteResult(
            label: top.key,
            confidence: top.value,
          ),
          isAnalyzing: false,
        );
      }
    } catch (e) {
      _logger.e('TFLite analysis failed: $e');
      state = state.copyWith(
        isAnalyzing: false,
        errorMessage: 'On-device analysis failed: $e',
      );
    }
  }

  /// Run Gemini Vision cloud analysis (detailed)
  Future<void> analyzeWithGemini({
    required Uint8List imageBytes,
    String mimeType = 'image/jpeg',
    String language = 'english',
  }) async {
    final geminiService = _ref.read(geminiPestServiceProvider);

    state = state.copyWith(
      isGeminiLoading: true,
      geminiReport: null,
      errorMessage: null,
    );

    try {
      final report = await geminiService.analyzeImage(
        imageBytes: imageBytes,
        mimeType: mimeType,
        language: language,
      );
      state = state.copyWith(
        geminiReport: report,
        isGeminiLoading: false,
      );
    } catch (e) {
      _logger.e('Gemini analysis failed: $e');
      state = state.copyWith(
        isGeminiLoading: false,
        errorMessage: 'Cloud analysis failed: ${_friendlyError(e)}',
      );
    }
  }

  /// Combined flow: TFLite first (instant), then Gemini (background)
  Future<void> analyzeImageFull(Uint8List imageBytes, {String language = 'english'}) async {
    // Reset
    state = state.copyWith(
      isAnalyzing: true,
      isGeminiLoading: false,
      tfliteResult: null,
      geminiReport: null,
      errorMessage: null,
    );

    // Step 1: On-device TFLite (instant, runs first)
    try {
      final tflite = _ref.read(tfliteServiceProvider);
      if (tflite.isLoaded) {
        final results = await tflite.analyzeImage(imageBytes: imageBytes);
        if (results.isNotEmpty) {
          final top = results.first;
          state = state.copyWith(
            tfliteResult: TfliteResult(
              label: top.key,
              confidence: top.value,
            ),
            isAnalyzing: false,
          );
        }
      } else {
        state = state.copyWith(isAnalyzing: false);
      }
    } catch (e) {
      state = state.copyWith(isAnalyzing: false);
    }

    // Step 2: Gemini cloud (runs in background, doesn't block UI)
    final geminiService = _ref.read(geminiPestServiceProvider);
    state = state.copyWith(isGeminiLoading: true);
    try {
      // Compress image for Gemini (save bandwidth)
      final compressed = _compressImage(imageBytes, maxSize: 1024);
      final report = await geminiService.analyzeImage(
        imageBytes: compressed,
        mimeType: 'image/jpeg',
        language: language,
      );
      state = state.copyWith(
        geminiReport: report,
        isGeminiLoading: false,
      );
    } catch (e) {
      _logger.e('Gemini cloud analysis failed: $e');
      state = state.copyWith(
        isGeminiLoading: false,
        errorMessage: 'Cloud analysis failed. On-device result still available.',
      );
    }
  }

  /// Reset analysis state
  void reset() {
    state = PestDetectionState(
      isTfliteReady: state.isTfliteReady,
    );
  } 

  /// Compress image to reduce upload size
  Uint8List _compressImage(Uint8List bytes, {int maxSize = 1024}) {
    final image = img_lib.decodeImage(bytes);
    if (image == null) return bytes;

    // Resize if larger than maxSize
    if (image.width > maxSize || image.height > maxSize) {
      final resized = img_lib.copyResize(
        image,
        width: image.width > image.height ? maxSize : null,
        height: image.height >= image.width ? maxSize : null,
        interpolation: img_lib.Interpolation.linear,
      );
      return Uint8List.fromList(img_lib.encodeJpg(resized, quality: 85));
    }

    return Uint8List.fromList(img_lib.encodeJpg(image, quality: 85));
  }

  String _friendlyError(dynamic e) {
    final msg = e.toString();
    if (msg.contains('API_KEY')) return 'Invalid API key. Check Settings.';
    if (msg.contains('QUOTA')) return 'API quota exceeded. Try again later.';
    if (msg.contains('NETWORK')) return 'No internet connection.';
    if (msg.contains('SAFETY')) return 'Image blocked by safety filter.';
    return 'Something went wrong. Try again.';
  }
}