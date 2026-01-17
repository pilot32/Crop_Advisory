// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pest_detection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PestDetectionModelImpl _$$PestDetectionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PestDetectionModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      imageUrl: json['imageUrl'] as String,
      detectionResult: json['detectionResult'] as String,
      pestOrDiseaseName: json['pestOrDiseaseName'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      cropName: json['cropName'] as String?,
      severity: json['severity'] as String?,
      description: json['description'] as String?,
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      treatments: (json['treatments'] as List<dynamic>?)
          ?.map((e) =>
              TreatmentRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] as String?,
      detectedAt: json['detectedAt'] == null
          ? null
          : DateTime.parse(json['detectedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PestDetectionModelImplToJson(
        _$PestDetectionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'imageUrl': instance.imageUrl,
      'detectionResult': instance.detectionResult,
      'pestOrDiseaseName': instance.pestOrDiseaseName,
      'confidence': instance.confidence,
      'cropName': instance.cropName,
      'severity': instance.severity,
      'description': instance.description,
      'symptoms': instance.symptoms,
      'treatments': instance.treatments,
      'location': instance.location,
      'detectedAt': instance.detectedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$TreatmentRecommendationImpl _$$TreatmentRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$TreatmentRecommendationImpl(
      method: json['method'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      dosage: json['dosage'] as String?,
      applicationMethod: json['applicationMethod'] as String?,
      precautions: (json['precautions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      effectivenessRating: (json['effectivenessRating'] as num?)?.toInt(),
      isOrganic: json['isOrganic'] as bool?,
    );

Map<String, dynamic> _$$TreatmentRecommendationImplToJson(
        _$TreatmentRecommendationImpl instance) =>
    <String, dynamic>{
      'method': instance.method,
      'name': instance.name,
      'description': instance.description,
      'dosage': instance.dosage,
      'applicationMethod': instance.applicationMethod,
      'precautions': instance.precautions,
      'effectivenessRating': instance.effectivenessRating,
      'isOrganic': instance.isOrganic,
    };
