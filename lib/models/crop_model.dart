/// Crop Model
/// 
/// Represents crop information and recommendations

import 'package:freezed_annotation/freezed_annotation.dart';

part 'crop_model.freezed.dart';
part 'crop_model.g.dart';

@freezed
class CropModel with _$CropModel {
  const factory CropModel({
    required String id,
    required String name,
    required String localName,
    String? imageUrl,
    String? description,
    String? season,
    int? growthDuration, // in days
    List<String>? suitableSoilTypes,
    double? minTemperature,
    double? maxTemperature,
    double? minRainfall, // in mm
    double? maxRainfall,
    String? waterRequirement,
    List<String>? commonPests,
    List<String>? commonDiseases,
    Map<String, dynamic>? fertilizerRecommendation,
    DateTime? createdAt,
  }) = _CropModel;

  factory CropModel.fromJson(Map<String, dynamic> json) =>
      _$CropModelFromJson(json);
}

@freezed
class CropAdvisory with _$CropAdvisory {
  const factory CropAdvisory({
    required String id,
    required String userId,
    required String cropId,
    required String cropName,
    required String advisory,
    required String season,
    double? confidenceScore,
    String? location,
    Map<String, dynamic>? weatherData,
    Map<String, dynamic>? soilData,
    DateTime? createdAt,
  }) = _CropAdvisory;

  factory CropAdvisory.fromJson(Map<String, dynamic> json) =>
      _$CropAdvisoryFromJson(json);
}
