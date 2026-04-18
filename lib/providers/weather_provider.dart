import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

part 'weather_provider.g.dart';

const _defaultLat = 19.0760;
const _defaultLon = 72.8777;
const _defaultCity = 'mumbai';

@riverpod
class CurrentWeather extends _$CurrentWeather {
  @override
  FutureOr<WeatherModel> build() async {
    final service = ref.watch(weatherServiceProvider);
    return service.getCurrentWeather(
      latitude: _defaultLat,
      longitude: _defaultLon,
    );
  }

  Future<void> refresh() async {
    final service = ref.read(weatherServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => service.getCurrentWeather(
        latitude: _defaultLat,
        longitude: _defaultLon,
      ),
    );
  }

  /// Fetch weather for a specific city by name
  Future<void> fetchByCity(String cityName) async {
    final service = ref.read(weatherServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => service.getCurrentWeatherByCity(cityName: cityName),
    );
  }
}

@riverpod
class WeatherForecastNotifier extends _$WeatherForecastNotifier {
  @override
  FutureOr<WeatherForecast> build() async {
    final service = ref.watch(weatherServiceProvider);
    return service.getForecast(
      latitude: _defaultLat,
      longitude: _defaultLon,
    );
  }

  /// Refresh forecast
  Future<void> refresh() async {
    final service = ref.read(weatherServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => service.getForecast(
          latitude: _defaultLat,
          longitude: _defaultLon,
        ));
  }
}
@riverpod
List<WeatherAlert> weatherAlerts(WeatherAlertsRef ref) {
  final weatherAsync = ref.watch(currentWeatherProvider);
  return weatherAsync.when(
    data: (weather) {
      final service = ref.read(weatherServiceProvider);
      return service.getMockWeatherAlerts(weather.location);
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
