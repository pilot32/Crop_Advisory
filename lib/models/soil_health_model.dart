/// Soil Health Model
/// 
/// Represents soil data and health analysis

import 'package:freezed_annotation/freezed_annotation.dart';

part 'soil_health_model.freezed.dart';
part 'soil_health_model.g.dart';

@freezed
class SoilHealthModel with _$SoilHealthModel {
  const factory SoilHealthModel({
    required String id,
    required String userId,
    required String soilType,
    required double ph,
    required double nitrogen, // kg/ha
    required double phosphorus, // kg/ha
    required double potassium, // kg/ha
    required double organicCarbon, // percentage
    double? ec, // Electrical conductivity
    double? moisture, // percentage
    String? texture,
    String? location,
    double? latitude,
    double? longitude,
    String? healthStatus, // poor, moderate, good, excellent
    Map<String, dynamic>? recommendations,
    DateTime? testedAt,
    DateTime? createdAt,
  }) = _SoilHealthModel;

  factory SoilHealthModel.fromJson(Map<String, dynamic> json) =>
      _$SoilHealthModelFromJson(json);
}

@freezed
class FertilizerRecommendation with _$FertilizerRecommendation {
  const factory FertilizerRecommendation({
    required String id,
    required String soilHealthId,
    required String cropName,
    required String fertilizerType,
    required double quantity, // kg/acre
    required String applicationMethod,
    required String timing,
    String? notes,
    List<String>? precautions,
    DateTime? createdAt,
  }) = _FertilizerRecommendation;

  factory FertilizerRecommendation.fromJson(Map<String, dynamic> json) =>
      _$FertilizerRecommendationFromJson(json);
}
