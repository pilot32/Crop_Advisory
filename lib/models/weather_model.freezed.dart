// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return _WeatherModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherModel {
  String get location => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError; // in Celsius
  double get feelsLike => throw _privateConstructorUsedError;
  String get condition =>
      throw _privateConstructorUsedError; // sunny, cloudy, rainy, etc.
  int get humidity => throw _privateConstructorUsedError; // percentage
  double get windSpeed => throw _privateConstructorUsedError; // km/h
  double get rainfall => throw _privateConstructorUsedError; // mm
  int get uvIndex => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get iconCode => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherModelCopyWith<WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherModelCopyWith<$Res> {
  factory $WeatherModelCopyWith(
          WeatherModel value, $Res Function(WeatherModel) then) =
      _$WeatherModelCopyWithImpl<$Res, WeatherModel>;
  @useResult
  $Res call(
      {String location,
      double temperature,
      double feelsLike,
      String condition,
      int humidity,
      double windSpeed,
      double rainfall,
      int uvIndex,
      String? description,
      String? iconCode,
      DateTime? timestamp});
}

/// @nodoc
class _$WeatherModelCopyWithImpl<$Res, $Val extends WeatherModel>
    implements $WeatherModelCopyWith<$Res> {
  _$WeatherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? temperature = null,
    Object? feelsLike = null,
    Object? condition = null,
    Object? humidity = null,
    Object? windSpeed = null,
    Object? rainfall = null,
    Object? uvIndex = null,
    Object? description = freezed,
    Object? iconCode = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      feelsLike: null == feelsLike
          ? _value.feelsLike
          : feelsLike // ignore: cast_nullable_to_non_nullable
              as double,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      rainfall: null == rainfall
          ? _value.rainfall
          : rainfall // ignore: cast_nullable_to_non_nullable
              as double,
      uvIndex: null == uvIndex
          ? _value.uvIndex
          : uvIndex // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherModelImplCopyWith<$Res>
    implements $WeatherModelCopyWith<$Res> {
  factory _$$WeatherModelImplCopyWith(
          _$WeatherModelImpl value, $Res Function(_$WeatherModelImpl) then) =
      __$$WeatherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String location,
      double temperature,
      double feelsLike,
      String condition,
      int humidity,
      double windSpeed,
      double rainfall,
      int uvIndex,
      String? description,
      String? iconCode,
      DateTime? timestamp});
}

/// @nodoc
class __$$WeatherModelImplCopyWithImpl<$Res>
    extends _$WeatherModelCopyWithImpl<$Res, _$WeatherModelImpl>
    implements _$$WeatherModelImplCopyWith<$Res> {
  __$$WeatherModelImplCopyWithImpl(
      _$WeatherModelImpl _value, $Res Function(_$WeatherModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? temperature = null,
    Object? feelsLike = null,
    Object? condition = null,
    Object? humidity = null,
    Object? windSpeed = null,
    Object? rainfall = null,
    Object? uvIndex = null,
    Object? description = freezed,
    Object? iconCode = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_$WeatherModelImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      feelsLike: null == feelsLike
          ? _value.feelsLike
          : feelsLike // ignore: cast_nullable_to_non_nullable
              as double,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      rainfall: null == rainfall
          ? _value.rainfall
          : rainfall // ignore: cast_nullable_to_non_nullable
              as double,
      uvIndex: null == uvIndex
          ? _value.uvIndex
          : uvIndex // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherModelImpl implements _WeatherModel {
  const _$WeatherModelImpl(
      {required this.location,
      required this.temperature,
      required this.feelsLike,
      required this.condition,
      required this.humidity,
      required this.windSpeed,
      required this.rainfall,
      required this.uvIndex,
      this.description,
      this.iconCode,
      this.timestamp});

  factory _$WeatherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherModelImplFromJson(json);

  @override
  final String location;
  @override
  final double temperature;
// in Celsius
  @override
  final double feelsLike;
  @override
  final String condition;
// sunny, cloudy, rainy, etc.
  @override
  final int humidity;
// percentage
  @override
  final double windSpeed;
// km/h
  @override
  final double rainfall;
// mm
  @override
  final int uvIndex;
  @override
  final String? description;
  @override
  final String? iconCode;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'WeatherModel(location: $location, temperature: $temperature, feelsLike: $feelsLike, condition: $condition, humidity: $humidity, windSpeed: $windSpeed, rainfall: $rainfall, uvIndex: $uvIndex, description: $description, iconCode: $iconCode, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherModelImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.feelsLike, feelsLike) ||
                other.feelsLike == feelsLike) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.rainfall, rainfall) ||
                other.rainfall == rainfall) &&
            (identical(other.uvIndex, uvIndex) || other.uvIndex == uvIndex) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconCode, iconCode) ||
                other.iconCode == iconCode) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      location,
      temperature,
      feelsLike,
      condition,
      humidity,
      windSpeed,
      rainfall,
      uvIndex,
      description,
      iconCode,
      timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherModelImplCopyWith<_$WeatherModelImpl> get copyWith =>
      __$$WeatherModelImplCopyWithImpl<_$WeatherModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherModelImplToJson(
      this,
    );
  }
}

abstract class _WeatherModel implements WeatherModel {
  const factory _WeatherModel(
      {required final String location,
      required final double temperature,
      required final double feelsLike,
      required final String condition,
      required final int humidity,
      required final double windSpeed,
      required final double rainfall,
      required final int uvIndex,
      final String? description,
      final String? iconCode,
      final DateTime? timestamp}) = _$WeatherModelImpl;

  factory _WeatherModel.fromJson(Map<String, dynamic> json) =
      _$WeatherModelImpl.fromJson;

  @override
  String get location;
  @override
  double get temperature;
  @override // in Celsius
  double get feelsLike;
  @override
  String get condition;
  @override // sunny, cloudy, rainy, etc.
  int get humidity;
  @override // percentage
  double get windSpeed;
  @override // km/h
  double get rainfall;
  @override // mm
  int get uvIndex;
  @override
  String? get description;
  @override
  String? get iconCode;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$WeatherModelImplCopyWith<_$WeatherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) {
  return _WeatherForecast.fromJson(json);
}

/// @nodoc
mixin _$WeatherForecast {
  String get location => throw _privateConstructorUsedError;
  List<DailyForecast> get daily => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherForecastCopyWith<WeatherForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherForecastCopyWith<$Res> {
  factory $WeatherForecastCopyWith(
          WeatherForecast value, $Res Function(WeatherForecast) then) =
      _$WeatherForecastCopyWithImpl<$Res, WeatherForecast>;
  @useResult
  $Res call({String location, List<DailyForecast> daily, DateTime? updatedAt});
}

/// @nodoc
class _$WeatherForecastCopyWithImpl<$Res, $Val extends WeatherForecast>
    implements $WeatherForecastCopyWith<$Res> {
  _$WeatherForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? daily = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      daily: null == daily
          ? _value.daily
          : daily // ignore: cast_nullable_to_non_nullable
              as List<DailyForecast>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherForecastImplCopyWith<$Res>
    implements $WeatherForecastCopyWith<$Res> {
  factory _$$WeatherForecastImplCopyWith(_$WeatherForecastImpl value,
          $Res Function(_$WeatherForecastImpl) then) =
      __$$WeatherForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String location, List<DailyForecast> daily, DateTime? updatedAt});
}

/// @nodoc
class __$$WeatherForecastImplCopyWithImpl<$Res>
    extends _$WeatherForecastCopyWithImpl<$Res, _$WeatherForecastImpl>
    implements _$$WeatherForecastImplCopyWith<$Res> {
  __$$WeatherForecastImplCopyWithImpl(
      _$WeatherForecastImpl _value, $Res Function(_$WeatherForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? daily = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$WeatherForecastImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      daily: null == daily
          ? _value._daily
          : daily // ignore: cast_nullable_to_non_nullable
              as List<DailyForecast>,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherForecastImpl implements _WeatherForecast {
  const _$WeatherForecastImpl(
      {required this.location,
      required final List<DailyForecast> daily,
      this.updatedAt})
      : _daily = daily;

  factory _$WeatherForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherForecastImplFromJson(json);

  @override
  final String location;
  final List<DailyForecast> _daily;
  @override
  List<DailyForecast> get daily {
    if (_daily is EqualUnmodifiableListView) return _daily;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_daily);
  }

  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WeatherForecast(location: $location, daily: $daily, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherForecastImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._daily, _daily) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location,
      const DeepCollectionEquality().hash(_daily), updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherForecastImplCopyWith<_$WeatherForecastImpl> get copyWith =>
      __$$WeatherForecastImplCopyWithImpl<_$WeatherForecastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherForecastImplToJson(
      this,
    );
  }
}

abstract class _WeatherForecast implements WeatherForecast {
  const factory _WeatherForecast(
      {required final String location,
      required final List<DailyForecast> daily,
      final DateTime? updatedAt}) = _$WeatherForecastImpl;

  factory _WeatherForecast.fromJson(Map<String, dynamic> json) =
      _$WeatherForecastImpl.fromJson;

  @override
  String get location;
  @override
  List<DailyForecast> get daily;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$WeatherForecastImplCopyWith<_$WeatherForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) {
  return _DailyForecast.fromJson(json);
}

/// @nodoc
mixin _$DailyForecast {
  DateTime get date => throw _privateConstructorUsedError;
  double get minTemp => throw _privateConstructorUsedError;
  double get maxTemp => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  int get humidity => throw _privateConstructorUsedError;
  double get rainfall => throw _privateConstructorUsedError;
  String? get iconCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyForecastCopyWith<DailyForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyForecastCopyWith<$Res> {
  factory $DailyForecastCopyWith(
          DailyForecast value, $Res Function(DailyForecast) then) =
      _$DailyForecastCopyWithImpl<$Res, DailyForecast>;
  @useResult
  $Res call(
      {DateTime date,
      double minTemp,
      double maxTemp,
      String condition,
      int humidity,
      double rainfall,
      String? iconCode});
}

/// @nodoc
class _$DailyForecastCopyWithImpl<$Res, $Val extends DailyForecast>
    implements $DailyForecastCopyWith<$Res> {
  _$DailyForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? minTemp = null,
    Object? maxTemp = null,
    Object? condition = null,
    Object? humidity = null,
    Object? rainfall = null,
    Object? iconCode = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minTemp: null == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as double,
      maxTemp: null == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as double,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      rainfall: null == rainfall
          ? _value.rainfall
          : rainfall // ignore: cast_nullable_to_non_nullable
              as double,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyForecastImplCopyWith<$Res>
    implements $DailyForecastCopyWith<$Res> {
  factory _$$DailyForecastImplCopyWith(
          _$DailyForecastImpl value, $Res Function(_$DailyForecastImpl) then) =
      __$$DailyForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      double minTemp,
      double maxTemp,
      String condition,
      int humidity,
      double rainfall,
      String? iconCode});
}

/// @nodoc
class __$$DailyForecastImplCopyWithImpl<$Res>
    extends _$DailyForecastCopyWithImpl<$Res, _$DailyForecastImpl>
    implements _$$DailyForecastImplCopyWith<$Res> {
  __$$DailyForecastImplCopyWithImpl(
      _$DailyForecastImpl _value, $Res Function(_$DailyForecastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? minTemp = null,
    Object? maxTemp = null,
    Object? condition = null,
    Object? humidity = null,
    Object? rainfall = null,
    Object? iconCode = freezed,
  }) {
    return _then(_$DailyForecastImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      minTemp: null == minTemp
          ? _value.minTemp
          : minTemp // ignore: cast_nullable_to_non_nullable
              as double,
      maxTemp: null == maxTemp
          ? _value.maxTemp
          : maxTemp // ignore: cast_nullable_to_non_nullable
              as double,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as int,
      rainfall: null == rainfall
          ? _value.rainfall
          : rainfall // ignore: cast_nullable_to_non_nullable
              as double,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyForecastImpl implements _DailyForecast {
  const _$DailyForecastImpl(
      {required this.date,
      required this.minTemp,
      required this.maxTemp,
      required this.condition,
      required this.humidity,
      required this.rainfall,
      this.iconCode});

  factory _$DailyForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyForecastImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double minTemp;
  @override
  final double maxTemp;
  @override
  final String condition;
  @override
  final int humidity;
  @override
  final double rainfall;
  @override
  final String? iconCode;

  @override
  String toString() {
    return 'DailyForecast(date: $date, minTemp: $minTemp, maxTemp: $maxTemp, condition: $condition, humidity: $humidity, rainfall: $rainfall, iconCode: $iconCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyForecastImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.minTemp, minTemp) || other.minTemp == minTemp) &&
            (identical(other.maxTemp, maxTemp) || other.maxTemp == maxTemp) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.rainfall, rainfall) ||
                other.rainfall == rainfall) &&
            (identical(other.iconCode, iconCode) ||
                other.iconCode == iconCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, minTemp, maxTemp,
      condition, humidity, rainfall, iconCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyForecastImplCopyWith<_$DailyForecastImpl> get copyWith =>
      __$$DailyForecastImplCopyWithImpl<_$DailyForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyForecastImplToJson(
      this,
    );
  }
}

abstract class _DailyForecast implements DailyForecast {
  const factory _DailyForecast(
      {required final DateTime date,
      required final double minTemp,
      required final double maxTemp,
      required final String condition,
      required final int humidity,
      required final double rainfall,
      final String? iconCode}) = _$DailyForecastImpl;

  factory _DailyForecast.fromJson(Map<String, dynamic> json) =
      _$DailyForecastImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get minTemp;
  @override
  double get maxTemp;
  @override
  String get condition;
  @override
  int get humidity;
  @override
  double get rainfall;
  @override
  String? get iconCode;
  @override
  @JsonKey(ignore: true)
  _$$DailyForecastImplCopyWith<_$DailyForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherAlert _$WeatherAlertFromJson(Map<String, dynamic> json) {
  return _WeatherAlert.fromJson(json);
}

/// @nodoc
mixin _$WeatherAlert {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get severity =>
      throw _privateConstructorUsedError; // low, medium, high, critical
  String get alertType =>
      throw _privateConstructorUsedError; // rain, storm, heatwave, etc.
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherAlertCopyWith<WeatherAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherAlertCopyWith<$Res> {
  factory $WeatherAlertCopyWith(
          WeatherAlert value, $Res Function(WeatherAlert) then) =
      _$WeatherAlertCopyWithImpl<$Res, WeatherAlert>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String severity,
      String alertType,
      DateTime startTime,
      DateTime endTime,
      String? location,
      bool? isActive});
}

/// @nodoc
class _$WeatherAlertCopyWithImpl<$Res, $Val extends WeatherAlert>
    implements $WeatherAlertCopyWith<$Res> {
  _$WeatherAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? alertType = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherAlertImplCopyWith<$Res>
    implements $WeatherAlertCopyWith<$Res> {
  factory _$$WeatherAlertImplCopyWith(
          _$WeatherAlertImpl value, $Res Function(_$WeatherAlertImpl) then) =
      __$$WeatherAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String severity,
      String alertType,
      DateTime startTime,
      DateTime endTime,
      String? location,
      bool? isActive});
}

/// @nodoc
class __$$WeatherAlertImplCopyWithImpl<$Res>
    extends _$WeatherAlertCopyWithImpl<$Res, _$WeatherAlertImpl>
    implements _$$WeatherAlertImplCopyWith<$Res> {
  __$$WeatherAlertImplCopyWithImpl(
      _$WeatherAlertImpl _value, $Res Function(_$WeatherAlertImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? alertType = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? location = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$WeatherAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherAlertImpl implements _WeatherAlert {
  const _$WeatherAlertImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.severity,
      required this.alertType,
      required this.startTime,
      required this.endTime,
      this.location,
      this.isActive});

  factory _$WeatherAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String severity;
// low, medium, high, critical
  @override
  final String alertType;
// rain, storm, heatwave, etc.
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String? location;
  @override
  final bool? isActive;

  @override
  String toString() {
    return 'WeatherAlert(id: $id, title: $title, description: $description, severity: $severity, alertType: $alertType, startTime: $startTime, endTime: $endTime, location: $location, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, severity,
      alertType, startTime, endTime, location, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherAlertImplCopyWith<_$WeatherAlertImpl> get copyWith =>
      __$$WeatherAlertImplCopyWithImpl<_$WeatherAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherAlertImplToJson(
      this,
    );
  }
}

abstract class _WeatherAlert implements WeatherAlert {
  const factory _WeatherAlert(
      {required final String id,
      required final String title,
      required final String description,
      required final String severity,
      required final String alertType,
      required final DateTime startTime,
      required final DateTime endTime,
      final String? location,
      final bool? isActive}) = _$WeatherAlertImpl;

  factory _WeatherAlert.fromJson(Map<String, dynamic> json) =
      _$WeatherAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get severity;
  @override // low, medium, high, critical
  String get alertType;
  @override // rain, storm, heatwave, etc.
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String? get location;
  @override
  bool? get isActive;
  @override
  @JsonKey(ignore: true)
  _$$WeatherAlertImplCopyWith<_$WeatherAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
