// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soil_health_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoilHealthModelImpl _$$SoilHealthModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SoilHealthModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      soilType: json['soilType'] as String,
      ph: (json['ph'] as num).toDouble(),
      nitrogen: (json['nitrogen'] as num).toDouble(),
      phosphorus: (json['phosphorus'] as num).toDouble(),
      potassium: (json['potassium'] as num).toDouble(),
      organicCarbon: (json['organicCarbon'] as num).toDouble(),
      ec: (json['ec'] as num?)?.toDouble(),
      moisture: (json['moisture'] as num?)?.toDouble(),
      texture: json['texture'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      healthStatus: json['healthStatus'] as String?,
      recommendations: json['recommendations'] as Map<String, dynamic>?,
      testedAt: json['testedAt'] == null
          ? null
          : DateTime.parse(json['testedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SoilHealthModelImplToJson(
        _$SoilHealthModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'soilType': instance.soilType,
      'ph': instance.ph,
      'nitrogen': instance.nitrogen,
      'phosphorus': instance.phosphorus,
      'potassium': instance.potassium,
      'organicCarbon': instance.organicCarbon,
      'ec': instance.ec,
      'moisture': instance.moisture,
      'texture': instance.texture,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'healthStatus': instance.healthStatus,
      'recommendations': instance.recommendations,
      'testedAt': instance.testedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$FertilizerRecommendationImpl _$$FertilizerRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$FertilizerRecommendationImpl(
      id: json['id'] as String,
      soilHealthId: json['soilHealthId'] as String,
      cropName: json['cropName'] as String,
      fertilizerType: json['fertilizerType'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      applicationMethod: json['applicationMethod'] as String,
      timing: json['timing'] as String,
      notes: json['notes'] as String?,
      precautions: (json['precautions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FertilizerRecommendationImplToJson(
        _$FertilizerRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'soilHealthId': instance.soilHealthId,
      'cropName': instance.cropName,
      'fertilizerType': instance.fertilizerType,
      'quantity': instance.quantity,
      'applicationMethod': instance.applicationMethod,
      'timing': instance.timing,
      'notes': instance.notes,
      'precautions': instance.precautions,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
