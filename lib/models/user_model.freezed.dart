// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get village => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String get languagePreference => throw _privateConstructorUsedError;
  List<String> get cropsGrown => throw _privateConstructorUsedError;
  double? get farmSize => throw _privateConstructorUsedError; // in acres
  String? get soilType => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String? phoneNumber,
      String? fullName,
      String? avatarUrl,
      String? state,
      String? district,
      String? village,
      double? latitude,
      double? longitude,
      String languagePreference,
      List<String> cropsGrown,
      double? farmSize,
      String? soilType,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? state = freezed,
    Object? district = freezed,
    Object? village = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? languagePreference = null,
    Object? cropsGrown = null,
    Object? farmSize = freezed,
    Object? soilType = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      village: freezed == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      languagePreference: null == languagePreference
          ? _value.languagePreference
          : languagePreference // ignore: cast_nullable_to_non_nullable
              as String,
      cropsGrown: null == cropsGrown
          ? _value.cropsGrown
          : cropsGrown // ignore: cast_nullable_to_non_nullable
              as List<String>,
      farmSize: freezed == farmSize
          ? _value.farmSize
          : farmSize // ignore: cast_nullable_to_non_nullable
              as double?,
      soilType: freezed == soilType
          ? _value.soilType
          : soilType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String? phoneNumber,
      String? fullName,
      String? avatarUrl,
      String? state,
      String? district,
      String? village,
      double? latitude,
      double? longitude,
      String languagePreference,
      List<String> cropsGrown,
      double? farmSize,
      String? soilType,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? fullName = freezed,
    Object? avatarUrl = freezed,
    Object? state = freezed,
    Object? district = freezed,
    Object? village = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? languagePreference = null,
    Object? cropsGrown = null,
    Object? farmSize = freezed,
    Object? soilType = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      village: freezed == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      languagePreference: null == languagePreference
          ? _value.languagePreference
          : languagePreference // ignore: cast_nullable_to_non_nullable
              as String,
      cropsGrown: null == cropsGrown
          ? _value._cropsGrown
          : cropsGrown // ignore: cast_nullable_to_non_nullable
              as List<String>,
      farmSize: freezed == farmSize
          ? _value.farmSize
          : farmSize // ignore: cast_nullable_to_non_nullable
              as double?,
      soilType: freezed == soilType
          ? _value.soilType
          : soilType // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.email,
      this.phoneNumber,
      this.fullName,
      this.avatarUrl,
      this.state,
      this.district,
      this.village,
      this.latitude,
      this.longitude,
      this.languagePreference = 'en',
      final List<String> cropsGrown = const [],
      this.farmSize,
      this.soilType,
      this.createdAt,
      this.updatedAt})
      : _cropsGrown = cropsGrown;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? fullName;
  @override
  final String? avatarUrl;
  @override
  final String? state;
  @override
  final String? district;
  @override
  final String? village;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final String languagePreference;
  final List<String> _cropsGrown;
  @override
  @JsonKey()
  List<String> get cropsGrown {
    if (_cropsGrown is EqualUnmodifiableListView) return _cropsGrown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cropsGrown);
  }

  @override
  final double? farmSize;
// in acres
  @override
  final String? soilType;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, phoneNumber: $phoneNumber, fullName: $fullName, avatarUrl: $avatarUrl, state: $state, district: $district, village: $village, latitude: $latitude, longitude: $longitude, languagePreference: $languagePreference, cropsGrown: $cropsGrown, farmSize: $farmSize, soilType: $soilType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.village, village) || other.village == village) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.languagePreference, languagePreference) ||
                other.languagePreference == languagePreference) &&
            const DeepCollectionEquality()
                .equals(other._cropsGrown, _cropsGrown) &&
            (identical(other.farmSize, farmSize) ||
                other.farmSize == farmSize) &&
            (identical(other.soilType, soilType) ||
                other.soilType == soilType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      phoneNumber,
      fullName,
      avatarUrl,
      state,
      district,
      village,
      latitude,
      longitude,
      languagePreference,
      const DeepCollectionEquality().hash(_cropsGrown),
      farmSize,
      soilType,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String email,
      final String? phoneNumber,
      final String? fullName,
      final String? avatarUrl,
      final String? state,
      final String? district,
      final String? village,
      final double? latitude,
      final double? longitude,
      final String languagePreference,
      final List<String> cropsGrown,
      final double? farmSize,
      final String? soilType,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get fullName;
  @override
  String? get avatarUrl;
  @override
  String? get state;
  @override
  String? get district;
  @override
  String? get village;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String get languagePreference;
  @override
  List<String> get cropsGrown;
  @override
  double? get farmSize;
  @override // in acres
  String? get soilType;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
