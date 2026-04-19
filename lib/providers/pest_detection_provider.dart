/// Pest Detection Provider
///
/// State management for plant disease detection

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../models/pest_detection_model.dart';
import '../services/huggingFaceService.dart';
import '../core/config/env_config.dart';

final _logger = Logger();

class PestDetectionState {
  final XFile? selectedImage;
  final PestDetectionModel? detectionResult;
  final bool isAnalyzing;
  final String? errorMessage;

  const PestDetectionState({
    this.selectedImage,
    this.detectionResult,
    this.isAnalyzing = false,
    this.errorMessage,
  });

  PestDetectionState copyWith({
    XFile? selectedImage,
    PestDetectionModel? detectionResult,
    bool? isAnalyzing,
    String? errorMessage,
    bool clearImage = false,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return PestDetectionState(
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
      detectionResult: clearResult
          ? null
          : (detectionResult ?? this.detectionResult),
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class PestDetectionNotifier extends StateNotifier<PestDetectionState> {
  final HuggingFaceService _hfService;
  final ImagePicker _picker = ImagePicker();

  PestDetectionNotifier(this._hfService) : super(const PestDetectionState());

  /// Pick image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image != null) {
        state = state.copyWith(
          selectedImage: image,
          clearResult: true,
          clearError: true,
        );
      }
    } catch (e) {
      _logger.e('Error picking image: $e');
      state = state.copyWith(errorMessage: 'Failed to pick image: $e');
    }
  }

  /// Analyze the selected image for diseases
  Future<void> analyzeImage() async {
    if (state.selectedImage == null) {
      state = state.copyWith(errorMessage: 'Please select an image first');
      return;
    }

    state = state.copyWith(isAnalyzing: true, clearError: true);

    try {
      // Send image path directly — service handles reading bytes internally
      final result = await _hfService.detectDisease(state.selectedImage!.path);

      state = state.copyWith(isAnalyzing: false, detectionResult: result);
    } catch (e) {
      _logger.e('Analysis failed: $e');
      state = state.copyWith(
        isAnalyzing: false,
        errorMessage: 'Analysis failed: $e',
      );
    }
  }

  /// Reset everything
  void reset() {
    state = const PestDetectionState();
  }
}

// Provides the HuggingFaceService instance with API key from env
final huggingFaceServiceProvider = Provider<HuggingFaceService>((ref) {
  final config = ref.watch(envConfigProvider);
  return HuggingFaceService(apiKey: config.hfApiKey ?? '');
});

// Providers
final pestDetectionProvider =
    StateNotifierProvider<PestDetectionNotifier, PestDetectionState>((ref) {
      final hfService = ref.watch(huggingFaceServiceProvider);
      return PestDetectionNotifier(hfService);
    });
