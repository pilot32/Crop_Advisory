// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherModelImpl _$$WeatherModelImplFromJson(Map<String, dynamic> json) =>
    _$WeatherModelImpl(
      location: json['location'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      condition: json['condition'] as String,
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      rainfall: (json['rainfall'] as num).toDouble(),
      uvIndex: (json['uvIndex'] as num).toInt(),
      description: json['description'] as String?,
      iconCode: json['iconCode'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$WeatherModelImplToJson(_$WeatherModelImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'condition': instance.condition,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'rainfall': instance.rainfall,
      'uvIndex': instance.uvIndex,
      'description': instance.description,
      'iconCode': instance.iconCode,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

_$WeatherForecastImpl _$$WeatherForecastImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherForecastImpl(
      location: json['location'] as String,
      daily: (json['daily'] as List<dynamic>)
          .map((e) => DailyForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WeatherForecastImplToJson(
        _$WeatherForecastImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'daily': instance.daily,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$DailyForecastImpl _$$DailyForecastImplFromJson(Map<String, dynamic> json) =>
    _$DailyForecastImpl(
      date: DateTime.parse(json['date'] as String),
      minTemp: (json['minTemp'] as num).toDouble(),
      maxTemp: (json['maxTemp'] as num).toDouble(),
      condition: json['condition'] as String,
      humidity: (json['humidity'] as num).toInt(),
      rainfall: (json['rainfall'] as num).toDouble(),
      iconCode: json['iconCode'] as String?,
    );

Map<String, dynamic> _$$DailyForecastImplToJson(_$DailyForecastImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'minTemp': instance.minTemp,
      'maxTemp': instance.maxTemp,
      'condition': instance.condition,
      'humidity': instance.humidity,
      'rainfall': instance.rainfall,
      'iconCode': instance.iconCode,
    };

_$WeatherAlertImpl _$$WeatherAlertImplFromJson(Map<String, dynamic> json) =>
    _$WeatherAlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      alertType: json['alertType'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$WeatherAlertImplToJson(_$WeatherAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'severity': instance.severity,
      'alertType': instance.alertType,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'location': instance.location,
      'isActive': instance.isActive,
    };
