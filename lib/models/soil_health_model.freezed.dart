// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'soil_health_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SoilHealthModel _$SoilHealthModelFromJson(Map<String, dynamic> json) {
  return _SoilHealthModel.fromJson(json);
}

/// @nodoc
mixin _$SoilHealthModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get soilType => throw _privateConstructorUsedError;
  double get ph => throw _privateConstructorUsedError;
  double get nitrogen => throw _privateConstructorUsedError; // kg/ha
  double get phosphorus => throw _privateConstructorUsedError; // kg/ha
  double get potassium => throw _privateConstructorUsedError; // kg/ha
  double get organicCarbon => throw _privateConstructorUsedError; // percentage
  double? get ec =>
      throw _privateConstructorUsedError; // Electrical conductivity
  double? get moisture => throw _privateConstructorUsedError; // percentage
  String? get texture => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get healthStatus =>
      throw _privateConstructorUsedError; // poor, moderate, good, excellent
  Map<String, dynamic>? get recommendations =>
      throw _privateConstructorUsedError;
  DateTime? get testedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SoilHealthModelCopyWith<SoilHealthModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoilHealthModelCopyWith<$Res> {
  factory $SoilHealthModelCopyWith(
          SoilHealthModel value, $Res Function(SoilHealthModel) then) =
      _$SoilHealthModelCopyWithImpl<$Res, SoilHealthModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String soilType,
      double ph,
      double nitrogen,
      double phosphorus,
      double potassium,
      double organicCarbon,
      double? ec,
      double? moisture,
      String? texture,
      String? location,
      double? latitude,
      double? longitude,
      String? healthStatus,
      Map<String, dynamic>? recommendations,
      DateTime? testedAt,
      DateTime? createdAt});
}

/// @nodoc
class _$SoilHealthModelCopyWithImpl<$Res, $Val extends SoilHealthModel>
    implements $SoilHealthModelCopyWith<$Res> {
  _$SoilHealthModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? soilType = null,
    Object? ph = null,
    Object? nitrogen = null,
    Object? phosphorus = null,
    Object? potassium = null,
    Object? organicCarbon = null,
    Object? ec = freezed,
    Object? moisture = freezed,
    Object? texture = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? healthStatus = freezed,
    Object? recommendations = freezed,
    Object? testedAt = freezed,
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
      soilType: null == soilType
          ? _value.soilType
          : soilType // ignore: cast_nullable_to_non_nullable
              as String,
      ph: null == ph
          ? _value.ph
          : ph // ignore: cast_nullable_to_non_nullable
              as double,
      nitrogen: null == nitrogen
          ? _value.nitrogen
          : nitrogen // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorus: null == phosphorus
          ? _value.phosphorus
          : phosphorus // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: null == potassium
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      organicCarbon: null == organicCarbon
          ? _value.organicCarbon
          : organicCarbon // ignore: cast_nullable_to_non_nullable
              as double,
      ec: freezed == ec
          ? _value.ec
          : ec // ignore: cast_nullable_to_non_nullable
              as double?,
      moisture: freezed == moisture
          ? _value.moisture
          : moisture // ignore: cast_nullable_to_non_nullable
              as double?,
      texture: freezed == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      healthStatus: freezed == healthStatus
          ? _value.healthStatus
          : healthStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendations: freezed == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      testedAt: freezed == testedAt
          ? _value.testedAt
          : testedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SoilHealthModelImplCopyWith<$Res>
    implements $SoilHealthModelCopyWith<$Res> {
  factory _$$SoilHealthModelImplCopyWith(_$SoilHealthModelImpl value,
          $Res Function(_$SoilHealthModelImpl) then) =
      __$$SoilHealthModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String soilType,
      double ph,
      double nitrogen,
      double phosphorus,
      double potassium,
      double organicCarbon,
      double? ec,
      double? moisture,
      String? texture,
      String? location,
      double? latitude,
      double? longitude,
      String? healthStatus,
      Map<String, dynamic>? recommendations,
      DateTime? testedAt,
      DateTime? createdAt});
}

/// @nodoc
class __$$SoilHealthModelImplCopyWithImpl<$Res>
    extends _$SoilHealthModelCopyWithImpl<$Res, _$SoilHealthModelImpl>
    implements _$$SoilHealthModelImplCopyWith<$Res> {
  __$$SoilHealthModelImplCopyWithImpl(
      _$SoilHealthModelImpl _value, $Res Function(_$SoilHealthModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? soilType = null,
    Object? ph = null,
    Object? nitrogen = null,
    Object? phosphorus = null,
    Object? potassium = null,
    Object? organicCarbon = null,
    Object? ec = freezed,
    Object? moisture = freezed,
    Object? texture = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? healthStatus = freezed,
    Object? recommendations = freezed,
    Object? testedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$SoilHealthModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      soilType: null == soilType
          ? _value.soilType
          : soilType // ignore: cast_nullable_to_non_nullable
              as String,
      ph: null == ph
          ? _value.ph
          : ph // ignore: cast_nullable_to_non_nullable
              as double,
      nitrogen: null == nitrogen
          ? _value.nitrogen
          : nitrogen // ignore: cast_nullable_to_non_nullable
              as double,
      phosphorus: null == phosphorus
          ? _value.phosphorus
          : phosphorus // ignore: cast_nullable_to_non_nullable
              as double,
      potassium: null == potassium
          ? _value.potassium
          : potassium // ignore: cast_nullable_to_non_nullable
              as double,
      organicCarbon: null == organicCarbon
          ? _value.organicCarbon
          : organicCarbon // ignore: cast_nullable_to_non_nullable
              as double,
      ec: freezed == ec
          ? _value.ec
          : ec // ignore: cast_nullable_to_non_nullable
              as double?,
      moisture: freezed == moisture
          ? _value.moisture
          : moisture // ignore: cast_nullable_to_non_nullable
              as double?,
      texture: freezed == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      healthStatus: freezed == healthStatus
          ? _value.healthStatus
          : healthStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendations: freezed == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      testedAt: freezed == testedAt
          ? _value.testedAt
          : testedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SoilHealthModelImpl implements _SoilHealthModel {
  const _$SoilHealthModelImpl(
      {required this.id,
      required this.userId,
      required this.soilType,
      required this.ph,
      required this.nitrogen,
      required this.phosphorus,
      required this.potassium,
      required this.organicCarbon,
      this.ec,
      this.moisture,
      this.texture,
      this.location,
      this.latitude,
      this.longitude,
      this.healthStatus,
      final Map<String, dynamic>? recommendations,
      this.testedAt,
      this.createdAt})
      : _recommendations = recommendations;

  factory _$SoilHealthModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SoilHealthModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String soilType;
  @override
  final double ph;
  @override
  final double nitrogen;
// kg/ha
  @override
  final double phosphorus;
// kg/ha
  @override
  final double potassium;
// kg/ha
  @override
  final double organicCarbon;
// percentage
  @override
  final double? ec;
// Electrical conductivity
  @override
  final double? moisture;
// percentage
  @override
  final String? texture;
  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? healthStatus;
// poor, moderate, good, excellent
  final Map<String, dynamic>? _recommendations;
// poor, moderate, good, excellent
  @override
  Map<String, dynamic>? get recommendations {
    final value = _recommendations;
    if (value == null) return null;
    if (_recommendations is EqualUnmodifiableMapView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? testedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SoilHealthModel(id: $id, userId: $userId, soilType: $soilType, ph: $ph, nitrogen: $nitrogen, phosphorus: $phosphorus, potassium: $potassium, organicCarbon: $organicCarbon, ec: $ec, moisture: $moisture, texture: $texture, location: $location, latitude: $latitude, longitude: $longitude, healthStatus: $healthStatus, recommendations: $recommendations, testedAt: $testedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoilHealthModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.soilType, soilType) ||
                other.soilType == soilType) &&
            (identical(other.ph, ph) || other.ph == ph) &&
            (identical(other.nitrogen, nitrogen) ||
                other.nitrogen == nitrogen) &&
            (identical(other.phosphorus, phosphorus) ||
                other.phosphorus == phosphorus) &&
            (identical(other.potassium, potassium) ||
                other.potassium == potassium) &&
            (identical(other.organicCarbon, organicCarbon) ||
                other.organicCarbon == organicCarbon) &&
            (identical(other.ec, ec) || other.ec == ec) &&
            (identical(other.moisture, moisture) ||
                other.moisture == moisture) &&
            (identical(other.texture, texture) || other.texture == texture) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.healthStatus, healthStatus) ||
                other.healthStatus == healthStatus) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.testedAt, testedAt) ||
                other.testedAt == testedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      soilType,
      ph,
      nitrogen,
      phosphorus,
      potassium,
      organicCarbon,
      ec,
      moisture,
      texture,
      location,
      latitude,
      longitude,
      healthStatus,
      const DeepCollectionEquality().hash(_recommendations),
      testedAt,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SoilHealthModelImplCopyWith<_$SoilHealthModelImpl> get copyWith =>
      __$$SoilHealthModelImplCopyWithImpl<_$SoilHealthModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SoilHealthModelImplToJson(
      this,
    );
  }
}

abstract class _SoilHealthModel implements SoilHealthModel {
  const factory _SoilHealthModel(
      {required final String id,
      required final String userId,
      required final String soilType,
      required final double ph,
      required final double nitrogen,
      required final double phosphorus,
      required final double potassium,
      required final double organicCarbon,
      final double? ec,
      final double? moisture,
      final String? texture,
      final String? location,
      final double? latitude,
      final double? longitude,
      final String? healthStatus,
      final Map<String, dynamic>? recommendations,
      final DateTime? testedAt,
      final DateTime? createdAt}) = _$SoilHealthModelImpl;

  factory _SoilHealthModel.fromJson(Map<String, dynamic> json) =
      _$SoilHealthModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get soilType;
  @override
  double get ph;
  @override
  double get nitrogen;
  @override // kg/ha
  double get phosphorus;
  @override // kg/ha
  double get potassium;
  @override // kg/ha
  double get organicCarbon;
  @override // percentage
  double? get ec;
  @override // Electrical conductivity
  double? get moisture;
  @override // percentage
  String? get texture;
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get healthStatus;
  @override // poor, moderate, good, excellent
  Map<String, dynamic>? get recommendations;
  @override
  DateTime? get testedAt;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$SoilHealthModelImplCopyWith<_$SoilHealthModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FertilizerRecommendation _$FertilizerRecommendationFromJson(
    Map<String, dynamic> json) {
  return _FertilizerRecommendation.fromJson(json);
}

/// @nodoc
mixin _$FertilizerRecommendation {
  String get id => throw _privateConstructorUsedError;
  String get soilHealthId => throw _privateConstructorUsedError;
  String get cropName => throw _privateConstructorUsedError;
  String get fertilizerType => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError; // kg/acre
  String get applicationMethod => throw _privateConstructorUsedError;
  String get timing => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String>? get precautions => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FertilizerRecommendationCopyWith<FertilizerRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FertilizerRecommendationCopyWith<$Res> {
  factory $FertilizerRecommendationCopyWith(FertilizerRecommendation value,
          $Res Function(FertilizerRecommendation) then) =
      _$FertilizerRecommendationCopyWithImpl<$Res, FertilizerRecommendation>;
  @useResult
  $Res call(
      {String id,
      String soilHealthId,
      String cropName,
      String fertilizerType,
      double quantity,
      String applicationMethod,
      String timing,
      String? notes,
      List<String>? precautions,
      DateTime? createdAt});
}

/// @nodoc
class _$FertilizerRecommendationCopyWithImpl<$Res,
        $Val extends FertilizerRecommendation>
    implements $FertilizerRecommendationCopyWith<$Res> {
  _$FertilizerRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? soilHealthId = null,
    Object? cropName = null,
    Object? fertilizerType = null,
    Object? quantity = null,
    Object? applicationMethod = null,
    Object? timing = null,
    Object? notes = freezed,
    Object? precautions = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      soilHealthId: null == soilHealthId
          ? _value.soilHealthId
          : soilHealthId // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      fertilizerType: null == fertilizerType
          ? _value.fertilizerType
          : fertilizerType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      applicationMethod: null == applicationMethod
          ? _value.applicationMethod
          : applicationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      timing: null == timing
          ? _value.timing
          : timing // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      precautions: freezed == precautions
          ? _value.precautions
          : precautions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FertilizerRecommendationImplCopyWith<$Res>
    implements $FertilizerRecommendationCopyWith<$Res> {
  factory _$$FertilizerRecommendationImplCopyWith(
          _$FertilizerRecommendationImpl value,
          $Res Function(_$FertilizerRecommendationImpl) then) =
      __$$FertilizerRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String soilHealthId,
      String cropName,
      String fertilizerType,
      double quantity,
      String applicationMethod,
      String timing,
      String? notes,
      List<String>? precautions,
      DateTime? createdAt});
}

/// @nodoc
class __$$FertilizerRecommendationImplCopyWithImpl<$Res>
    extends _$FertilizerRecommendationCopyWithImpl<$Res,
        _$FertilizerRecommendationImpl>
    implements _$$FertilizerRecommendationImplCopyWith<$Res> {
  __$$FertilizerRecommendationImplCopyWithImpl(
      _$FertilizerRecommendationImpl _value,
      $Res Function(_$FertilizerRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? soilHealthId = null,
    Object? cropName = null,
    Object? fertilizerType = null,
    Object? quantity = null,
    Object? applicationMethod = null,
    Object? timing = null,
    Object? notes = freezed,
    Object? precautions = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FertilizerRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      soilHealthId: null == soilHealthId
          ? _value.soilHealthId
          : soilHealthId // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      fertilizerType: null == fertilizerType
          ? _value.fertilizerType
          : fertilizerType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      applicationMethod: null == applicationMethod
          ? _value.applicationMethod
          : applicationMethod // ignore: cast_nullable_to_non_nullable
              as String,
      timing: null == timing
          ? _value.timing
          : timing // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      precautions: freezed == precautions
          ? _value._precautions
          : precautions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FertilizerRecommendationImpl implements _FertilizerRecommendation {
  const _$FertilizerRecommendationImpl(
      {required this.id,
      required this.soilHealthId,
      required this.cropName,
      required this.fertilizerType,
      required this.quantity,
      required this.applicationMethod,
      required this.timing,
      this.notes,
      final List<String>? precautions,
      this.createdAt})
      : _precautions = precautions;

  factory _$FertilizerRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FertilizerRecommendationImplFromJson(json);

  @override
  final String id;
  @override
  final String soilHealthId;
  @override
  final String cropName;
  @override
  final String fertilizerType;
  @override
  final double quantity;
// kg/acre
  @override
  final String applicationMethod;
  @override
  final String timing;
  @override
  final String? notes;
  final List<String>? _precautions;
  @override
  List<String>? get precautions {
    final value = _precautions;
    if (value == null) return null;
    if (_precautions is EqualUnmodifiableListView) return _precautions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FertilizerRecommendation(id: $id, soilHealthId: $soilHealthId, cropName: $cropName, fertilizerType: $fertilizerType, quantity: $quantity, applicationMethod: $applicationMethod, timing: $timing, notes: $notes, precautions: $precautions, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FertilizerRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.soilHealthId, soilHealthId) ||
                other.soilHealthId == soilHealthId) &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            (identical(other.fertilizerType, fertilizerType) ||
                other.fertilizerType == fertilizerType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.applicationMethod, applicationMethod) ||
                other.applicationMethod == applicationMethod) &&
            (identical(other.timing, timing) || other.timing == timing) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._precautions, _precautions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      soilHealthId,
      cropName,
      fertilizerType,
      quantity,
      applicationMethod,
      timing,
      notes,
      const DeepCollectionEquality().hash(_precautions),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FertilizerRecommendationImplCopyWith<_$FertilizerRecommendationImpl>
      get copyWith => __$$FertilizerRecommendationImplCopyWithImpl<
          _$FertilizerRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FertilizerRecommendationImplToJson(
      this,
    );
  }
}

abstract class _FertilizerRecommendation implements FertilizerRecommendation {
  const factory _FertilizerRecommendation(
      {required final String id,
      required final String soilHealthId,
      required final String cropName,
      required final String fertilizerType,
      required final double quantity,
      required final String applicationMethod,
      required final String timing,
      final String? notes,
      final List<String>? precautions,
      final DateTime? createdAt}) = _$FertilizerRecommendationImpl;

  factory _FertilizerRecommendation.fromJson(Map<String, dynamic> json) =
      _$FertilizerRecommendationImpl.fromJson;

  @override
  String get id;
  @override
  String get soilHealthId;
  @override
  String get cropName;
  @override
  String get fertilizerType;
  @override
  double get quantity;
  @override // kg/acre
  String get applicationMethod;
  @override
  String get timing;
  @override
  String? get notes;
  @override
  List<String>? get precautions;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FertilizerRecommendationImplCopyWith<_$FertilizerRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
