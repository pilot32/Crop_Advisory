/// Pest Detection Provider
///
/// State management for plant disease detection
/// TODO: Step 5 - Replace with TFLite on-device model

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../models/pest_detection_model.dart';

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
  final ImagePicker _picker = ImagePicker();

  PestDetectionNotifier() : super(const PestDetectionState());

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
  /// TODO: Step 5 - Replace with TFLite inference
  Future<void> analyzeImage() async {
    if (state.selectedImage == null) {
      state = state.copyWith(errorMessage: 'Please select an image first');
      return;
    }

    state = state.copyWith(isAnalyzing: true, clearError: true);

    try {
      // Temporary placeholder until TFLite integration (Step 5)
      await Future.delayed(const Duration(seconds: 2));

      final result = PestDetectionModel(
        id: '',
        userId: '',
        imageUrl: state.selectedImage!.path,
        detectionResult: 'Healthy Plant',
        pestOrDiseaseName: 'Healthy',
        confidence: 0.85,
        cropName: 'Unknown',
        severity: 'None',
        description:
            'The plant appears healthy. Continue regular care and monitoring for early detection of any issues.',
        symptoms: [
          'Normal green leaf color',
          'No spots, lesions, or discoloration',
        ],
        treatments: [
          TreatmentRecommendation(
            name: 'Continue regular watering',
            description: 'Maintain consistent soil moisture',
            method: 'cultural',
          ),
        ],
        detectedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );

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

final pestDetectionProvider =
    StateNotifierProvider<PestDetectionNotifier, PestDetectionState>((ref) {
  return PestDetectionNotifier();
});