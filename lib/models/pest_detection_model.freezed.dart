// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pest_detection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PestDetectionModel _$PestDetectionModelFromJson(Map<String, dynamic> json) {
  return _PestDetectionModel.fromJson(json);
}

/// @nodoc
mixin _$PestDetectionModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get detectionResult => throw _privateConstructorUsedError;
  String get pestOrDiseaseName => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String? get cropName => throw _privateConstructorUsedError;
  String? get severity =>
      throw _privateConstructorUsedError; // low, medium, high
  String? get description => throw _privateConstructorUsedError;
  List<String>? get symptoms => throw _privateConstructorUsedError;
  List<TreatmentRecommendation>? get treatments =>
      throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  DateTime? get detectedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PestDetectionModelCopyWith<PestDetectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PestDetectionModelCopyWith<$Res> {
  factory $PestDetectionModelCopyWith(
          PestDetectionModel value, $Res Function(PestDetectionModel) then) =
      _$PestDetectionModelCopyWithImpl<$Res, PestDetectionModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String imageUrl,
      String detectionResult,
      String pestOrDiseaseName,
      double confidence,
      String? cropName,
      String? severity,
      String? description,
      List<String>? symptoms,
      List<TreatmentRecommendation>? treatments,
      String? location,
      DateTime? detectedAt,
      DateTime? createdAt});
}

/// @nodoc
class _$PestDetectionModelCopyWithImpl<$Res, $Val extends PestDetectionModel>
    implements $PestDetectionModelCopyWith<$Res> {
  _$PestDetectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? imageUrl = null,
    Object? detectionResult = null,
    Object? pestOrDiseaseName = null,
    Object? confidence = null,
    Object? cropName = freezed,
    Object? severity = freezed,
    Object? description = freezed,
    Object? symptoms = freezed,
    Object? treatments = freezed,
    Object? location = freezed,
    Object? detectedAt = freezed,
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
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      detectionResult: null == detectionResult
          ? _value.detectionResult
          : detectionResult // ignore: cast_nullable_to_non_nullable
              as String,
      pestOrDiseaseName: null == pestOrDiseaseName
          ? _value.pestOrDiseaseName
          : pestOrDiseaseName // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      cropName: freezed == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      symptoms: freezed == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      treatments: freezed == treatments
          ? _value.treatments
          : treatments // ignore: cast_nullable_to_non_nullable
              as List<TreatmentRecommendation>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      detectedAt: freezed == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PestDetectionModelImplCopyWith<$Res>
    implements $PestDetectionModelCopyWith<$Res> {
  factory _$$PestDetectionModelImplCopyWith(_$PestDetectionModelImpl value,
          $Res Function(_$PestDetectionModelImpl) then) =
      __$$PestDetectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String imageUrl,
      String detectionResult,
      String pestOrDiseaseName,
      double confidence,
      String? cropName,
      String? severity,
      String? description,
      List<String>? symptoms,
      List<TreatmentRecommendation>? treatments,
      String? location,
      DateTime? detectedAt,
      DateTime? createdAt});
}

/// @nodoc
class __$$PestDetectionModelImplCopyWithImpl<$Res>
    extends _$PestDetectionModelCopyWithImpl<$Res, _$PestDetectionModelImpl>
    implements _$$PestDetectionModelImplCopyWith<$Res> {
  __$$PestDetectionModelImplCopyWithImpl(_$PestDetectionModelImpl _value,
      $Res Function(_$PestDetectionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? imageUrl = null,
    Object? detectionResult = null,
    Object? pestOrDiseaseName = null,
    Object? confidence = null,
    Object? cropName = freezed,
    Object? severity = freezed,
    Object? description = freezed,
    Object? symptoms = freezed,
    Object? treatments = freezed,
    Object? location = freezed,
    Object? detectedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$PestDetectionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      detectionResult: null == detectionResult
          ? _value.detectionResult
          : detectionResult // ignore: cast_nullable_to_non_nullable
              as String,
      pestOrDiseaseName: null == pestOrDiseaseName
          ? _value.pestOrDiseaseName
          : pestOrDiseaseName // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      cropName: freezed == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      symptoms: freezed == symptoms
          ? _value._symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      treatments: freezed == treatments
          ? _value._treatments
          : treatments // ignore: cast_nullable_to_non_nullable
              as List<TreatmentRecommendation>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      detectedAt: freezed == detectedAt
          ? _value.detectedAt
          : detectedAt // ignore: cast_nullable_to_non_nullable
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
class _$PestDetectionModelImpl implements _PestDetectionModel {
  const _$PestDetectionModelImpl(
      {required this.id,
      required this.userId,
      required this.imageUrl,
      required this.detectionResult,
      required this.pestOrDiseaseName,
      required this.confidence,
      this.cropName,
      this.severity,
      this.description,
      final List<String>? symptoms,
      final List<TreatmentRecommendation>? treatments,
      this.location,
      this.detectedAt,
      this.createdAt})
      : _symptoms = symptoms,
        _treatments = treatments;

  factory _$PestDetectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PestDetectionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String imageUrl;
  @override
  final String detectionResult;
  @override
  final String pestOrDiseaseName;
  @override
  final double confidence;
  @override
  final String? cropName;
  @override
  final String? severity;
// low, medium, high
  @override
  final String? description;
  final List<String>? _symptoms;
  @override
  List<String>? get symptoms {
    final value = _symptoms;
    if (value == null) return null;
    if (_symptoms is EqualUnmodifiableListView) return _symptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TreatmentRecommendation>? _treatments;
  @override
  List<TreatmentRecommendation>? get treatments {
    final value = _treatments;
    if (value == null) return null;
    if (_treatments is EqualUnmodifiableListView) return _treatments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? location;
  @override
  final DateTime? detectedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PestDetectionModel(id: $id, userId: $userId, imageUrl: $imageUrl, detectionResult: $detectionResult, pestOrDiseaseName: $pestOrDiseaseName, confidence: $confidence, cropName: $cropName, severity: $severity, description: $description, symptoms: $symptoms, treatments: $treatments, location: $location, detectedAt: $detectedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PestDetectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.detectionResult, detectionResult) ||
                other.detectionResult == detectionResult) &&
            (identical(other.pestOrDiseaseName, pestOrDiseaseName) ||
                other.pestOrDiseaseName == pestOrDiseaseName) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._symptoms, _symptoms) &&
            const DeepCollectionEquality()
                .equals(other._treatments, _treatments) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.detectedAt, detectedAt) ||
                other.detectedAt == detectedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      imageUrl,
      detectionResult,
      pestOrDiseaseName,
      confidence,
      cropName,
      severity,
      description,
      const DeepCollectionEquality().hash(_symptoms),
      const DeepCollectionEquality().hash(_treatments),
      location,
      detectedAt,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PestDetectionModelImplCopyWith<_$PestDetectionModelImpl> get copyWith =>
      __$$PestDetectionModelImplCopyWithImpl<_$PestDetectionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PestDetectionModelImplToJson(
      this,
    );
  }
}

abstract class _PestDetectionModel implements PestDetectionModel {
  const factory _PestDetectionModel(
      {required final String id,
      required final String userId,
      required final String imageUrl,
      required final String detectionResult,
      required final String pestOrDiseaseName,
      required final double confidence,
      final String? cropName,
      final String? severity,
      final String? description,
      final List<String>? symptoms,
      final List<TreatmentRecommendation>? treatments,
      final String? location,
      final DateTime? detectedAt,
      final DateTime? createdAt}) = _$PestDetectionModelImpl;

  factory _PestDetectionModel.fromJson(Map<String, dynamic> json) =
      _$PestDetectionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get imageUrl;
  @override
  String get detectionResult;
  @override
  String get pestOrDiseaseName;
  @override
  double get confidence;
  @override
  String? get cropName;
  @override
  String? get severity;
  @override // low, medium, high
  String? get description;
  @override
  List<String>? get symptoms;
  @override
  List<TreatmentRecommendation>? get treatments;
  @override
  String? get location;
  @override
  DateTime? get detectedAt;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PestDetectionModelImplCopyWith<_$PestDetectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TreatmentRecommendation _$TreatmentRecommendationFromJson(
    Map<String, dynamic> json) {
  return _TreatmentRecommendation.fromJson(json);
}

/// @nodoc
mixin _$TreatmentRecommendation {
  String get method =>
      throw _privateConstructorUsedError; // chemical, organic, biological
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get dosage => throw _privateConstructorUsedError;
  String? get applicationMethod => throw _privateConstructorUsedError;
  List<String>? get precautions => throw _privateConstructorUsedError;
  int? get effectivenessRating => throw _privateConstructorUsedError; // 1-5
  bool? get isOrganic => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TreatmentRecommendationCopyWith<TreatmentRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreatmentRecommendationCopyWith<$Res> {
  factory $TreatmentRecommendationCopyWith(TreatmentRecommendation value,
          $Res Function(TreatmentRecommendation) then) =
      _$TreatmentRecommendationCopyWithImpl<$Res, TreatmentRecommendation>;
  @useResult
  $Res call(
      {String method,
      String name,
      String description,
      String? dosage,
      String? applicationMethod,
      List<String>? precautions,
      int? effectivenessRating,
      bool? isOrganic});
}

/// @nodoc
class _$TreatmentRecommendationCopyWithImpl<$Res,
        $Val extends TreatmentRecommendation>
    implements $TreatmentRecommendationCopyWith<$Res> {
  _$TreatmentRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? name = null,
    Object? description = null,
    Object? dosage = freezed,
    Object? applicationMethod = freezed,
    Object? precautions = freezed,
    Object? effectivenessRating = freezed,
    Object? isOrganic = freezed,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: freezed == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationMethod: freezed == applicationMethod
          ? _value.applicationMethod
          : applicationMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      precautions: freezed == precautions
          ? _value.precautions
          : precautions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      effectivenessRating: freezed == effectivenessRating
          ? _value.effectivenessRating
          : effectivenessRating // ignore: cast_nullable_to_non_nullable
              as int?,
      isOrganic: freezed == isOrganic
          ? _value.isOrganic
          : isOrganic // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TreatmentRecommendationImplCopyWith<$Res>
    implements $TreatmentRecommendationCopyWith<$Res> {
  factory _$$TreatmentRecommendationImplCopyWith(
          _$TreatmentRecommendationImpl value,
          $Res Function(_$TreatmentRecommendationImpl) then) =
      __$$TreatmentRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String method,
      String name,
      String description,
      String? dosage,
      String? applicationMethod,
      List<String>? precautions,
      int? effectivenessRating,
      bool? isOrganic});
}

/// @nodoc
class __$$TreatmentRecommendationImplCopyWithImpl<$Res>
    extends _$TreatmentRecommendationCopyWithImpl<$Res,
        _$TreatmentRecommendationImpl>
    implements _$$TreatmentRecommendationImplCopyWith<$Res> {
  __$$TreatmentRecommendationImplCopyWithImpl(
      _$TreatmentRecommendationImpl _value,
      $Res Function(_$TreatmentRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? name = null,
    Object? description = null,
    Object? dosage = freezed,
    Object? applicationMethod = freezed,
    Object? precautions = freezed,
    Object? effectivenessRating = freezed,
    Object? isOrganic = freezed,
  }) {
    return _then(_$TreatmentRecommendationImpl(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dosage: freezed == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationMethod: freezed == applicationMethod
          ? _value.applicationMethod
          : applicationMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      precautions: freezed == precautions
          ? _value._precautions
          : precautions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      effectivenessRating: freezed == effectivenessRating
          ? _value.effectivenessRating
          : effectivenessRating // ignore: cast_nullable_to_non_nullable
              as int?,
      isOrganic: freezed == isOrganic
          ? _value.isOrganic
          : isOrganic // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TreatmentRecommendationImpl implements _TreatmentRecommendation {
  const _$TreatmentRecommendationImpl(
      {required this.method,
      required this.name,
      required this.description,
      this.dosage,
      this.applicationMethod,
      final List<String>? precautions,
      this.effectivenessRating,
      this.isOrganic})
      : _precautions = precautions;

  factory _$TreatmentRecommendationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreatmentRecommendationImplFromJson(json);

  @override
  final String method;
// chemical, organic, biological
  @override
  final String name;
  @override
  final String description;
  @override
  final String? dosage;
  @override
  final String? applicationMethod;
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
  final int? effectivenessRating;
// 1-5
  @override
  final bool? isOrganic;

  @override
  String toString() {
    return 'TreatmentRecommendation(method: $method, name: $name, description: $description, dosage: $dosage, applicationMethod: $applicationMethod, precautions: $precautions, effectivenessRating: $effectivenessRating, isOrganic: $isOrganic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreatmentRecommendationImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.applicationMethod, applicationMethod) ||
                other.applicationMethod == applicationMethod) &&
            const DeepCollectionEquality()
                .equals(other._precautions, _precautions) &&
            (identical(other.effectivenessRating, effectivenessRating) ||
                other.effectivenessRating == effectivenessRating) &&
            (identical(other.isOrganic, isOrganic) ||
                other.isOrganic == isOrganic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      method,
      name,
      description,
      dosage,
      applicationMethod,
      const DeepCollectionEquality().hash(_precautions),
      effectivenessRating,
      isOrganic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TreatmentRecommendationImplCopyWith<_$TreatmentRecommendationImpl>
      get copyWith => __$$TreatmentRecommendationImplCopyWithImpl<
          _$TreatmentRecommendationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreatmentRecommendationImplToJson(
      this,
    );
  }
}

abstract class _TreatmentRecommendation implements TreatmentRecommendation {
  const factory _TreatmentRecommendation(
      {required final String method,
      required final String name,
      required final String description,
      final String? dosage,
      final String? applicationMethod,
      final List<String>? precautions,
      final int? effectivenessRating,
      final bool? isOrganic}) = _$TreatmentRecommendationImpl;

  factory _TreatmentRecommendation.fromJson(Map<String, dynamic> json) =
      _$TreatmentRecommendationImpl.fromJson;

  @override
  String get method;
  @override // chemical, organic, biological
  String get name;
  @override
  String get description;
  @override
  String? get dosage;
  @override
  String? get applicationMethod;
  @override
  List<String>? get precautions;
  @override
  int? get effectivenessRating;
  @override // 1-5
  bool? get isOrganic;
  @override
  @JsonKey(ignore: true)
  _$$TreatmentRecommendationImplCopyWith<_$TreatmentRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
