/// Weather Service
/// 
/// Handles fetching weather data from OpenWeatherMap API
/// Provides current weather, forecasts, and weather alerts

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import '../core/config/env_config.dart';
import '../models/weather_model.dart';

part 'weather_service.g.dart';

/// Weather service provider
@Riverpod(keepAlive: true)
WeatherService weatherService(WeatherServiceRef ref) {
  final config = ref.watch(envConfigProvider);
  return WeatherService(config.weatherApiKey ?? '');
}

/// Service class for weather operations
class WeatherService {
  final String _apiKey;
  final Logger _logger = Logger();
  final Dio _dio;

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  WeatherService(this._apiKey) : _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Get current weather by coordinates
  /// 
  /// Parameters:
  /// - [latitude]: Location latitude
  /// - [longitude]: Location longitude
  /// - [units]: Temperature units (metric, imperial)
  /// 
  /// Returns: WeatherModel with current weather data
  Future<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
    String units = 'metric',
  }) async {
    try {
      _logger.i('Fetching current weather for: $latitude, $longitude');

      if (_apiKey.isEmpty) {
        throw Exception('Weather API key not configured');
      }

      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': _apiKey,
          'units': units,
        },
      );

      _logger.i('Weather data fetched successfully');
      return _parseWeatherData(response.data);
    } catch (e) {
      _logger.e('Error fetching current weather: $e');
      rethrow;
    }
  }

  /// Get current weather by city name
  /// 
  /// Parameters:
  /// - [cityName]: Name of the city
  /// - [units]: Temperature units
  /// 
  /// Returns: WeatherModel with current weather data
  Future<WeatherModel> getCurrentWeatherByCity({
    required String cityName,
    String units = 'metric',
  }) async {
    try {
      _logger.i('Fetching current weather for city: $cityName');

      if (_apiKey.isEmpty) {
        throw Exception('Weather API key not configured');
      }

      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': units,
        },
      );

      _logger.i('Weather data fetched successfully');
      return _parseWeatherData(response.data);
    } catch (e) {
      _logger.e('Error fetching weather by city: $e');
      rethrow;
    }
  }

  /// Get 5-day weather forecast
  /// 
  /// Parameters:
  /// - [latitude]: Location latitude
  /// - [longitude]: Location longitude
  /// - [units]: Temperature units
  /// 
  /// Returns: WeatherForecast with daily forecasts
  Future<WeatherForecast> getForecast({
    required double latitude,
    required double longitude,
    String units = 'metric',
  }) async {
    try {
      _logger.i('Fetching weather forecast for: $latitude, $longitude');

      if (_apiKey.isEmpty) {
        throw Exception('Weather API key not configured');
      }

      final response = await _dio.get(
        '/forecast',
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'appid': _apiKey,
          'units': units,
        },
      );

      _logger.i('Forecast data fetched successfully');
      return _parseForecastData(response.data);
    } catch (e) {
      _logger.e('Error fetching forecast: $e');
      rethrow;
    }
  }

  /// Parse weather API response into WeatherModel
  WeatherModel _parseWeatherData(Map<String, dynamic> data) {
    try {
      final main = data['main'] as Map<String, dynamic>;
      
      final weather = (data['weather'] as List).first as Map<String, dynamic>;
      final wind = data['wind'] as Map<String, dynamic>;

      return WeatherModel(
        location: data['name'] ?? 'Unknown',
        temperature: (main['temp'] as num).toDouble(),
        feelsLike: (main['feels_like'] as num).toDouble(),
        condition: weather['main'] ?? 'Unknown',
        humidity: main['humidity'] ?? 0,
        windSpeed: (wind['speed'] as num).toDouble(),
        rainfall: data['rain']?['1h']?.toDouble() ?? 0.0,
        uvIndex: 0, // Not available in current weather API
        description: weather['description'],
        iconCode: weather['icon'],
        timestamp: DateTime.now(),
      );
    } catch (e) {
      _logger.e('Error parsing weather data: $e');
      throw Exception('Failed to parse weather data');
    }
  }

  /// Parse forecast API response into WeatherForecast
  WeatherForecast _parseForecastData(Map<String, dynamic> data) {
    try {
      final city = data['city'] as Map<String, dynamic>;
      final list = data['list'] as List;

      // Group forecasts by day
      final Map<String, List<Map<String, dynamic>>> dailyData = {};
      
      for (var item in list) {
        final dt = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
        final dateKey = '${dt.year}-${dt.month}-${dt.day}';
        
        if (!dailyData.containsKey(dateKey)) {
          dailyData[dateKey] = [];
        }
        dailyData[dateKey]!.add(item as Map<String, dynamic>);
      }

      // Create daily forecasts
      final dailyForecasts = dailyData.entries.map((entry) {
        final dayData = entry.value;
        final temps = dayData.map((d) => (d['main']['temp'] as num).toDouble()).toList();
        final rainfall = dayData.fold<double>(0.0, (sum, d) => sum + (d['rain']?['3h']?.toDouble() ?? 0.0));
        
        return DailyForecast(
          date: DateTime.fromMillisecondsSinceEpoch(dayData.first['dt'] * 1000),
          minTemp: temps.reduce((a, b) => a < b ? a : b),
          maxTemp: temps.reduce((a, b) => a > b ? a : b),
          condition: dayData.first['weather'][0]['main'],
          humidity: dayData.first['main']['humidity'],
          rainfall: rainfall,
          iconCode: dayData.first['weather'][0]['icon'],
        );
      }).toList();

      return WeatherForecast(
        location: city['name'] ?? 'Unknown',
        daily: dailyForecasts,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      _logger.e('Error parsing forecast data: $e');
      throw Exception('Failed to parse forecast data');
    }
  }

  /// Create mock weather alerts (OpenWeatherMap alerts require paid plan)
  /// 
  /// In production, this should be replaced with actual API call or
  /// integrated with local weather department APIs
  List<WeatherAlert> getMockWeatherAlerts(String location) {
    return [
      WeatherAlert(
        id: '1',
        title: 'Heavy Rainfall Expected',
        description: 'Heavy to very heavy rainfall is expected in the next 48 hours',
        severity: 'high',
        alertType: 'rain',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(days: 2)),
        location: location,
        isActive: true,
      ),
    ];
  }
}
