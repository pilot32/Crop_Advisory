import 'package:flutter_test/flutter_test.dart';
import 'package:crop_advisory/providers/pest_detection_provider.dart';

void main() {
  group('PestDetectionState', () {
    test('default state has correct initial values', () {
      const state = PestDetectionState();
      expect(state.isAnalyzing, isFalse);
      expect(state.isTfliteReady, isFalse);
      expect(state.tfliteResult, isNull);
      expect(state.geminiReport, isNull);
      expect(state.isGeminiLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.modelLoadError, isFalse);
    });

    test('copyWith updates isAnalyzing', () {
      const state = PestDetectionState();
      final updated = state.copyWith(isAnalyzing: true);
      expect(updated.isAnalyzing, isTrue);
      expect(updated.isTfliteReady, isFalse); // others unchanged
    });

    test('copyWith updates isTfliteReady', () {
      const state = PestDetectionState();
      final updated = state.copyWith(isTfliteReady: true);
      expect(updated.isTfliteReady, isTrue);
    });

    test('copyWith updates tfliteResult', () {
      const state = PestDetectionState();
      const result = TfliteResult(label: 'Tomato___healthy', confidence: 0.9);
      final updated = state.copyWith(tfliteResult: result);
      expect(updated.tfliteResult, isNotNull);
      expect(updated.tfliteResult!.label, equals('Tomato___healthy'));
    });

    test('copyWith updates geminiReport', () {
      const state = PestDetectionState();
      final updated = state.copyWith(geminiReport: 'Disease detected');
      expect(updated.geminiReport, equals('Disease detected'));
    });

    test('copyWith updates isGeminiLoading', () {
      const state = PestDetectionState();
      final updated = state.copyWith(isGeminiLoading: true);
      expect(updated.isGeminiLoading, isTrue);
    });

    test('copyWith can set errorMessage to null (clear error)', () {
      final stateWithError = const PestDetectionState().copyWith(
        errorMessage: 'Something broke',
      );
      expect(stateWithError.errorMessage, equals('Something broke'));

      final cleared = stateWithError.copyWith(errorMessage: null);
      // The implementation of copyWith explicitly uses `errorMessage: errorMessage`
      // instead of `errorMessage: errorMessage ?? this.errorMessage`
      // so it correctly resets the error when not passed or set to null.
      expect(cleared.errorMessage, isNull);
    });

    test('copyWith updates modelLoadError', () {
      const state = PestDetectionState();
      final updated = state.copyWith(modelLoadError: true);
      expect(updated.modelLoadError, isTrue);
    });

    test('multiple copyWith calls accumulate changes', () {
      const state = PestDetectionState();
      final updated = state
          .copyWith(isAnalyzing: true)
          .copyWith(isTfliteReady: true);
      expect(updated.isAnalyzing, isTrue);
      expect(updated.isTfliteReady, isTrue);
    });
  });
}