// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CropModelImpl _$$CropModelImplFromJson(Map<String, dynamic> json) =>
    _$CropModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      localName: json['localName'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      season: json['season'] as String?,
      growthDuration: (json['growthDuration'] as num?)?.toInt(),
      suitableSoilTypes: (json['suitableSoilTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      minTemperature: (json['minTemperature'] as num?)?.toDouble(),
      maxTemperature: (json['maxTemperature'] as num?)?.toDouble(),
      minRainfall: (json['minRainfall'] as num?)?.toDouble(),
      maxRainfall: (json['maxRainfall'] as num?)?.toDouble(),
      waterRequirement: json['waterRequirement'] as String?,
      commonPests: (json['commonPests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      commonDiseases: (json['commonDiseases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fertilizerRecommendation:
          json['fertilizerRecommendation'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CropModelImplToJson(_$CropModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'localName': instance.localName,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'season': instance.season,
      'growthDuration': instance.growthDuration,
      'suitableSoilTypes': instance.suitableSoilTypes,
      'minTemperature': instance.minTemperature,
      'maxTemperature': instance.maxTemperature,
      'minRainfall': instance.minRainfall,
      'maxRainfall': instance.maxRainfall,
      'waterRequirement': instance.waterRequirement,
      'commonPests': instance.commonPests,
      'commonDiseases': instance.commonDiseases,
      'fertilizerRecommendation': instance.fertilizerRecommendation,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$CropAdvisoryImpl _$$CropAdvisoryImplFromJson(Map<String, dynamic> json) =>
    _$CropAdvisoryImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cropId: json['cropId'] as String,
      cropName: json['cropName'] as String,
      advisory: json['advisory'] as String,
      season: json['season'] as String,
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      location: json['location'] as String?,
      weatherData: json['weatherData'] as Map<String, dynamic>?,
      soilData: json['soilData'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CropAdvisoryImplToJson(_$CropAdvisoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cropId': instance.cropId,
      'cropName': instance.cropName,
      'advisory': instance.advisory,
      'season': instance.season,
      'confidenceScore': instance.confidenceScore,
      'location': instance.location,
      'weatherData': instance.weatherData,
      'soilData': instance.soilData,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
