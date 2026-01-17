// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      village: json['village'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      languagePreference: json['languagePreference'] as String? ?? 'en',
      cropsGrown: (json['cropsGrown'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      farmSize: (json['farmSize'] as num?)?.toDouble(),
      soilType: json['soilType'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'state': instance.state,
      'district': instance.district,
      'village': instance.village,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'languagePreference': instance.languagePreference,
      'cropsGrown': instance.cropsGrown,
      'farmSize': instance.farmSize,
      'soilType': instance.soilType,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
