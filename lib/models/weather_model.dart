/// Weather Model
/// 
/// Represents weather data and forecasts

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required String location,
    required double temperature, // in Celsius
    required double feelsLike,
    required String condition, // sunny, cloudy, rainy, etc.
    required int humidity, // percentage
    required double windSpeed, // km/h
    required double rainfall, // mm
    required int uvIndex,
    String? description,
    String? iconCode,
    DateTime? timestamp,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@freezed
class WeatherForecast with _$WeatherForecast {
  const factory WeatherForecast({
    required String location,
    required List<DailyForecast> daily,
    DateTime? updatedAt,
  }) = _WeatherForecast;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);
}

@freezed
class DailyForecast with _$DailyForecast {
  const factory DailyForecast({
    required DateTime date,
    required double minTemp,
    required double maxTemp,
    required String condition,
    required int humidity,
    required double rainfall,
    String? iconCode,
  }) = _DailyForecast;

  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);
}

@freezed
class WeatherAlert with _$WeatherAlert {
  const factory WeatherAlert({
    required String id,
    required String title,
    required String description,
    required String severity, // low, medium, high, critical
    required String alertType, // rain, storm, heatwave, etc.
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    bool? isActive,
  }) = _WeatherAlert;

  factory WeatherAlert.fromJson(Map<String, dynamic> json) =>
      _$WeatherAlertFromJson(json);
}
