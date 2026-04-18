// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherAlertsHash() => r'86798a455be59325ea9e1100e1a2992597693169';

/// See also [weatherAlerts].
@ProviderFor(weatherAlerts)
final weatherAlertsProvider = AutoDisposeProvider<List<WeatherAlert>>.internal(
  weatherAlerts,
  name: r'weatherAlertsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherAlertsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeatherAlertsRef = AutoDisposeProviderRef<List<WeatherAlert>>;
String _$currentWeatherHash() => r'9bf224b29db8305413c09bf9190026b23dc98966';

/// See also [CurrentWeather].
@ProviderFor(CurrentWeather)
final currentWeatherProvider =
    AutoDisposeAsyncNotifierProvider<CurrentWeather, WeatherModel>.internal(
  CurrentWeather.new,
  name: r'currentWeatherProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentWeatherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentWeather = AutoDisposeAsyncNotifier<WeatherModel>;
String _$weatherForecastNotifierHash() =>
    r'3a1c841608fee06ba7ba4bd3aa8dbd7d8dffea31';

/// See also [WeatherForecastNotifier].
@ProviderFor(WeatherForecastNotifier)
final weatherForecastNotifierProvider = AutoDisposeAsyncNotifierProvider<
    WeatherForecastNotifier, WeatherForecast>.internal(
  WeatherForecastNotifier.new,
  name: r'weatherForecastNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherForecastNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherForecastNotifier = AutoDisposeAsyncNotifier<WeatherForecast>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
