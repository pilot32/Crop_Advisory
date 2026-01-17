// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CropModel _$CropModelFromJson(Map<String, dynamic> json) {
  return _CropModel.fromJson(json);
}

/// @nodoc
mixin _$CropModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get localName => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get season => throw _privateConstructorUsedError;
  int? get growthDuration => throw _privateConstructorUsedError; // in days
  List<String>? get suitableSoilTypes => throw _privateConstructorUsedError;
  double? get minTemperature => throw _privateConstructorUsedError;
  double? get maxTemperature => throw _privateConstructorUsedError;
  double? get minRainfall => throw _privateConstructorUsedError; // in mm
  double? get maxRainfall => throw _privateConstructorUsedError;
  String? get waterRequirement => throw _privateConstructorUsedError;
  List<String>? get commonPests => throw _privateConstructorUsedError;
  List<String>? get commonDiseases => throw _privateConstructorUsedError;
  Map<String, dynamic>? get fertilizerRecommendation =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CropModelCopyWith<CropModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropModelCopyWith<$Res> {
  factory $CropModelCopyWith(CropModel value, $Res Function(CropModel) then) =
      _$CropModelCopyWithImpl<$Res, CropModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String localName,
      String? imageUrl,
      String? description,
      String? season,
      int? growthDuration,
      List<String>? suitableSoilTypes,
      double? minTemperature,
      double? maxTemperature,
      double? minRainfall,
      double? maxRainfall,
      String? waterRequirement,
      List<String>? commonPests,
      List<String>? commonDiseases,
      Map<String, dynamic>? fertilizerRecommendation,
      DateTime? createdAt});
}

/// @nodoc
class _$CropModelCopyWithImpl<$Res, $Val extends CropModel>
    implements $CropModelCopyWith<$Res> {
  _$CropModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? localName = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? season = freezed,
    Object? growthDuration = freezed,
    Object? suitableSoilTypes = freezed,
    Object? minTemperature = freezed,
    Object? maxTemperature = freezed,
    Object? minRainfall = freezed,
    Object? maxRainfall = freezed,
    Object? waterRequirement = freezed,
    Object? commonPests = freezed,
    Object? commonDiseases = freezed,
    Object? fertilizerRecommendation = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      localName: null == localName
          ? _value.localName
          : localName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      growthDuration: freezed == growthDuration
          ? _value.growthDuration
          : growthDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      suitableSoilTypes: freezed == suitableSoilTypes
          ? _value.suitableSoilTypes
          : suitableSoilTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      minTemperature: freezed == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      maxTemperature: freezed == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      minRainfall: freezed == minRainfall
          ? _value.minRainfall
          : minRainfall // ignore: cast_nullable_to_non_nullable
              as double?,
      maxRainfall: freezed == maxRainfall
          ? _value.maxRainfall
          : maxRainfall // ignore: cast_nullable_to_non_nullable
              as double?,
      waterRequirement: freezed == waterRequirement
          ? _value.waterRequirement
          : waterRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      commonPests: freezed == commonPests
          ? _value.commonPests
          : commonPests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      commonDiseases: freezed == commonDiseases
          ? _value.commonDiseases
          : commonDiseases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fertilizerRecommendation: freezed == fertilizerRecommendation
          ? _value.fertilizerRecommendation
          : fertilizerRecommendation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CropModelImplCopyWith<$Res>
    implements $CropModelCopyWith<$Res> {
  factory _$$CropModelImplCopyWith(
          _$CropModelImpl value, $Res Function(_$CropModelImpl) then) =
      __$$CropModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String localName,
      String? imageUrl,
      String? description,
      String? season,
      int? growthDuration,
      List<String>? suitableSoilTypes,
      double? minTemperature,
      double? maxTemperature,
      double? minRainfall,
      double? maxRainfall,
      String? waterRequirement,
      List<String>? commonPests,
      List<String>? commonDiseases,
      Map<String, dynamic>? fertilizerRecommendation,
      DateTime? createdAt});
}

/// @nodoc
class __$$CropModelImplCopyWithImpl<$Res>
    extends _$CropModelCopyWithImpl<$Res, _$CropModelImpl>
    implements _$$CropModelImplCopyWith<$Res> {
  __$$CropModelImplCopyWithImpl(
      _$CropModelImpl _value, $Res Function(_$CropModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? localName = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? season = freezed,
    Object? growthDuration = freezed,
    Object? suitableSoilTypes = freezed,
    Object? minTemperature = freezed,
    Object? maxTemperature = freezed,
    Object? minRainfall = freezed,
    Object? maxRainfall = freezed,
    Object? waterRequirement = freezed,
    Object? commonPests = freezed,
    Object? commonDiseases = freezed,
    Object? fertilizerRecommendation = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CropModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      localName: null == localName
          ? _value.localName
          : localName // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      growthDuration: freezed == growthDuration
          ? _value.growthDuration
          : growthDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      suitableSoilTypes: freezed == suitableSoilTypes
          ? _value._suitableSoilTypes
          : suitableSoilTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      minTemperature: freezed == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      maxTemperature: freezed == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as double?,
      minRainfall: freezed == minRainfall
          ? _value.minRainfall
          : minRainfall // ignore: cast_nullable_to_non_nullable
              as double?,
      maxRainfall: freezed == maxRainfall
          ? _value.maxRainfall
          : maxRainfall // ignore: cast_nullable_to_non_nullable
              as double?,
      waterRequirement: freezed == waterRequirement
          ? _value.waterRequirement
          : waterRequirement // ignore: cast_nullable_to_non_nullable
              as String?,
      commonPests: freezed == commonPests
          ? _value._commonPests
          : commonPests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      commonDiseases: freezed == commonDiseases
          ? _value._commonDiseases
          : commonDiseases // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      fertilizerRecommendation: freezed == fertilizerRecommendation
          ? _value._fertilizerRecommendation
          : fertilizerRecommendation // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CropModelImpl implements _CropModel {
  const _$CropModelImpl(
      {required this.id,
      required this.name,
      required this.localName,
      this.imageUrl,
      this.description,
      this.season,
      this.growthDuration,
      final List<String>? suitableSoilTypes,
      this.minTemperature,
      this.maxTemperature,
      this.minRainfall,
      this.maxRainfall,
      this.waterRequirement,
      final List<String>? commonPests,
      final List<String>? commonDiseases,
      final Map<String, dynamic>? fertilizerRecommendation,
      this.createdAt})
      : _suitableSoilTypes = suitableSoilTypes,
        _commonPests = commonPests,
        _commonDiseases = commonDiseases,
        _fertilizerRecommendation = fertilizerRecommendation;

  factory _$CropModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CropModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String localName;
  @override
  final String? imageUrl;
  @override
  final String? description;
  @override
  final String? season;
  @override
  final int? growthDuration;
// in days
  final List<String>? _suitableSoilTypes;
// in days
  @override
  List<String>? get suitableSoilTypes {
    final value = _suitableSoilTypes;
    if (value == null) return null;
    if (_suitableSoilTypes is EqualUnmodifiableListView)
      return _suitableSoilTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? minTemperature;
  @override
  final double? maxTemperature;
  @override
  final double? minRainfall;
// in mm
  @override
  final double? maxRainfall;
  @override
  final String? waterRequirement;
  final List<String>? _commonPests;
  @override
  List<String>? get commonPests {
    final value = _commonPests;
    if (value == null) return null;
    if (_commonPests is EqualUnmodifiableListView) return _commonPests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _commonDiseases;
  @override
  List<String>? get commonDiseases {
    final value = _commonDiseases;
    if (value == null) return null;
    if (_commonDiseases is EqualUnmodifiableListView) return _commonDiseases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _fertilizerRecommendation;
  @override
  Map<String, dynamic>? get fertilizerRecommendation {
    final value = _fertilizerRecommendation;
    if (value == null) return null;
    if (_fertilizerRecommendation is EqualUnmodifiableMapView)
      return _fertilizerRecommendation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CropModel(id: $id, name: $name, localName: $localName, imageUrl: $imageUrl, description: $description, season: $season, growthDuration: $growthDuration, suitableSoilTypes: $suitableSoilTypes, minTemperature: $minTemperature, maxTemperature: $maxTemperature, minRainfall: $minRainfall, maxRainfall: $maxRainfall, waterRequirement: $waterRequirement, commonPests: $commonPests, commonDiseases: $commonDiseases, fertilizerRecommendation: $fertilizerRecommendation, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CropModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.localName, localName) ||
                other.localName == localName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.growthDuration, growthDuration) ||
                other.growthDuration == growthDuration) &&
            const DeepCollectionEquality()
                .equals(other._suitableSoilTypes, _suitableSoilTypes) &&
            (identical(other.minTemperature, minTemperature) ||
                other.minTemperature == minTemperature) &&
            (identical(other.maxTemperature, maxTemperature) ||
                other.maxTemperature == maxTemperature) &&
            (identical(other.minRainfall, minRainfall) ||
                other.minRainfall == minRainfall) &&
            (identical(other.maxRainfall, maxRainfall) ||
                other.maxRainfall == maxRainfall) &&
            (identical(other.waterRequirement, waterRequirement) ||
                other.waterRequirement == waterRequirement) &&
            const DeepCollectionEquality()
                .equals(other._commonPests, _commonPests) &&
            const DeepCollectionEquality()
                .equals(other._commonDiseases, _commonDiseases) &&
            const DeepCollectionEquality().equals(
                other._fertilizerRecommendation, _fertilizerRecommendation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      localName,
      imageUrl,
      description,
      season,
      growthDuration,
      const DeepCollectionEquality().hash(_suitableSoilTypes),
      minTemperature,
      maxTemperature,
      minRainfall,
      maxRainfall,
      waterRequirement,
      const DeepCollectionEquality().hash(_commonPests),
      const DeepCollectionEquality().hash(_commonDiseases),
      const DeepCollectionEquality().hash(_fertilizerRecommendation),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CropModelImplCopyWith<_$CropModelImpl> get copyWith =>
      __$$CropModelImplCopyWithImpl<_$CropModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CropModelImplToJson(
      this,
    );
  }
}

abstract class _CropModel implements CropModel {
  const factory _CropModel(
      {required final String id,
      required final String name,
      required final String localName,
      final String? imageUrl,
      final String? description,
      final String? season,
      final int? growthDuration,
      final List<String>? suitableSoilTypes,
      final double? minTemperature,
      final double? maxTemperature,
      final double? minRainfall,
      final double? maxRainfall,
      final String? waterRequirement,
      final List<String>? commonPests,
      final List<String>? commonDiseases,
      final Map<String, dynamic>? fertilizerRecommendation,
      final DateTime? createdAt}) = _$CropModelImpl;

  factory _CropModel.fromJson(Map<String, dynamic> json) =
      _$CropModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get localName;
  @override
  String? get imageUrl;
  @override
  String? get description;
  @override
  String? get season;
  @override
  int? get growthDuration;
  @override // in days
  List<String>? get suitableSoilTypes;
  @override
  double? get minTemperature;
  @override
  double? get maxTemperature;
  @override
  double? get minRainfall;
  @override // in mm
  double? get maxRainfall;
  @override
  String? get waterRequirement;
  @override
  List<String>? get commonPests;
  @override
  List<String>? get commonDiseases;
  @override
  Map<String, dynamic>? get fertilizerRecommendation;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CropModelImplCopyWith<_$CropModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CropAdvisory _$CropAdvisoryFromJson(Map<String, dynamic> json) {
  return _CropAdvisory.fromJson(json);
}

/// @nodoc
mixin _$CropAdvisory {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get cropId => throw _privateConstructorUsedError;
  String get cropName => throw _privateConstructorUsedError;
  String get advisory => throw _privateConstructorUsedError;
  String get season => throw _privateConstructorUsedError;
  double? get confidenceScore => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  Map<String, dynamic>? get weatherData => throw _privateConstructorUsedError;
  Map<String, dynamic>? get soilData => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CropAdvisoryCopyWith<CropAdvisory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CropAdvisoryCopyWith<$Res> {
  factory $CropAdvisoryCopyWith(
          CropAdvisory value, $Res Function(CropAdvisory) then) =
      _$CropAdvisoryCopyWithImpl<$Res, CropAdvisory>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String cropId,
      String cropName,
      String advisory,
      String season,
      double? confidenceScore,
      String? location,
      Map<String, dynamic>? weatherData,
      Map<String, dynamic>? soilData,
      DateTime? createdAt});
}

/// @nodoc
class _$CropAdvisoryCopyWithImpl<$Res, $Val extends CropAdvisory>
    implements $CropAdvisoryCopyWith<$Res> {
  _$CropAdvisoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cropId = null,
    Object? cropName = null,
    Object? advisory = null,
    Object? season = null,
    Object? confidenceScore = freezed,
    Object? location = freezed,
    Object? weatherData = freezed,
    Object? soilData = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cropId: null == cropId
          ? _value.cropId
          : cropId // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      advisory: null == advisory
          ? _value.advisory
          : advisory // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      confidenceScore: freezed == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherData: freezed == weatherData
          ? _value.weatherData
          : weatherData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      soilData: freezed == soilData
          ? _value.soilData
          : soilData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CropAdvisoryImplCopyWith<$Res>
    implements $CropAdvisoryCopyWith<$Res> {
  factory _$$CropAdvisoryImplCopyWith(
          _$CropAdvisoryImpl value, $Res Function(_$CropAdvisoryImpl) then) =
      __$$CropAdvisoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String cropId,
      String cropName,
      String advisory,
      String season,
      double? confidenceScore,
      String? location,
      Map<String, dynamic>? weatherData,
      Map<String, dynamic>? soilData,
      DateTime? createdAt});
}

/// @nodoc
class __$$CropAdvisoryImplCopyWithImpl<$Res>
    extends _$CropAdvisoryCopyWithImpl<$Res, _$CropAdvisoryImpl>
    implements _$$CropAdvisoryImplCopyWith<$Res> {
  __$$CropAdvisoryImplCopyWithImpl(
      _$CropAdvisoryImpl _value, $Res Function(_$CropAdvisoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? cropId = null,
    Object? cropName = null,
    Object? advisory = null,
    Object? season = null,
    Object? confidenceScore = freezed,
    Object? location = freezed,
    Object? weatherData = freezed,
    Object? soilData = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CropAdvisoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      cropId: null == cropId
          ? _value.cropId
          : cropId // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      advisory: null == advisory
          ? _value.advisory
          : advisory // ignore: cast_nullable_to_non_nullable
              as String,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
      confidenceScore: freezed == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherData: freezed == weatherData
          ? _value._weatherData
          : weatherData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      soilData: freezed == soilData
          ? _value._soilData
          : soilData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CropAdvisoryImpl implements _CropAdvisory {
  const _$CropAdvisoryImpl(
      {required this.id,
      required this.userId,
      required this.cropId,
      required this.cropName,
      required this.advisory,
      required this.season,
      this.confidenceScore,
      this.location,
      final Map<String, dynamic>? weatherData,
      final Map<String, dynamic>? soilData,
      this.createdAt})
      : _weatherData = weatherData,
        _soilData = soilData;

  factory _$CropAdvisoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CropAdvisoryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String cropId;
  @override
  final String cropName;
  @override
  final String advisory;
  @override
  final String season;
  @override
  final double? confidenceScore;
  @override
  final String? location;
  final Map<String, dynamic>? _weatherData;
  @override
  Map<String, dynamic>? get weatherData {
    final value = _weatherData;
    if (value == null) return null;
    if (_weatherData is EqualUnmodifiableMapView) return _weatherData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _soilData;
  @override
  Map<String, dynamic>? get soilData {
    final value = _soilData;
    if (value == null) return null;
    if (_soilData is EqualUnmodifiableMapView) return _soilData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CropAdvisory(id: $id, userId: $userId, cropId: $cropId, cropName: $cropName, advisory: $advisory, season: $season, confidenceScore: $confidenceScore, location: $location, weatherData: $weatherData, soilData: $soilData, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CropAdvisoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.cropId, cropId) || other.cropId == cropId) &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            (identical(other.advisory, advisory) ||
                other.advisory == advisory) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._weatherData, _weatherData) &&
            const DeepCollectionEquality().equals(other._soilData, _soilData) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      cropId,
      cropName,
      advisory,
      season,
      confidenceScore,
      location,
      const DeepCollectionEquality().hash(_weatherData),
      const DeepCollectionEquality().hash(_soilData),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CropAdvisoryImplCopyWith<_$CropAdvisoryImpl> get copyWith =>
      __$$CropAdvisoryImplCopyWithImpl<_$CropAdvisoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CropAdvisoryImplToJson(
      this,
    );
  }
}

abstract class _CropAdvisory implements CropAdvisory {
  const factory _CropAdvisory(
      {required final String id,
      required final String userId,
      required final String cropId,
      required final String cropName,
      required final String advisory,
      required final String season,
      final double? confidenceScore,
      final String? location,
      final Map<String, dynamic>? weatherData,
      final Map<String, dynamic>? soilData,
      final DateTime? createdAt}) = _$CropAdvisoryImpl;

  factory _CropAdvisory.fromJson(Map<String, dynamic> json) =
      _$CropAdvisoryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get cropId;
  @override
  String get cropName;
  @override
  String get advisory;
  @override
  String get season;
  @override
  double? get confidenceScore;
  @override
  String? get location;
  @override
  Map<String, dynamic>? get weatherData;
  @override
  Map<String, dynamic>? get soilData;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CropAdvisoryImplCopyWith<_$CropAdvisoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
