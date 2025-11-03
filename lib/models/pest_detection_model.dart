/// Pest Detection Model
/// 
/// Represents pest/disease detection and treatment information

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pest_detection_model.freezed.dart';
part 'pest_detection_model.g.dart';

@freezed
class PestDetectionModel with _$PestDetectionModel {
  const factory PestDetectionModel({
    required String id,
    required String userId,
    required String imageUrl,
    required String detectionResult,
    required String pestOrDiseaseName,
    required double confidence,
    String? cropName,
    String? severity, // low, medium, high
    String? description,
    List<String>? symptoms,
    List<TreatmentRecommendation>? treatments,
    String? location,
    DateTime? detectedAt,
    DateTime? createdAt,
  }) = _PestDetectionModel;

  factory PestDetectionModel.fromJson(Map<String, dynamic> json) =>
      _$PestDetectionModelFromJson(json);
}

@freezed
class TreatmentRecommendation with _$TreatmentRecommendation {
  const factory TreatmentRecommendation({
    required String method, // chemical, organic, biological
    required String name,
    required String description,
    String? dosage,
    String? applicationMethod,
    List<String>? precautions,
    int? effectivenessRating, // 1-5
    bool? isOrganic,
  }) = _TreatmentRecommendation;

  factory TreatmentRecommendation.fromJson(Map<String, dynamic> json) =>
      _$TreatmentRecommendationFromJson(json);
}
