// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_price_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarketPriceModel _$MarketPriceModelFromJson(Map<String, dynamic> json) {
  return _MarketPriceModel.fromJson(json);
}

/// @nodoc
mixin _$MarketPriceModel {
  String get id => throw _privateConstructorUsedError;
  String get cropName => throw _privateConstructorUsedError;
  String get variety => throw _privateConstructorUsedError;
  double get minPrice => throw _privateConstructorUsedError; // per quintal
  double get maxPrice => throw _privateConstructorUsedError;
  double get modalPrice => throw _privateConstructorUsedError;
  String get market => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get district => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  DateTime? get arrivalDate => throw _privateConstructorUsedError;
  DateTime? get recordedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarketPriceModelCopyWith<MarketPriceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketPriceModelCopyWith<$Res> {
  factory $MarketPriceModelCopyWith(
          MarketPriceModel value, $Res Function(MarketPriceModel) then) =
      _$MarketPriceModelCopyWithImpl<$Res, MarketPriceModel>;
  @useResult
  $Res call(
      {String id,
      String cropName,
      String variety,
      double minPrice,
      double maxPrice,
      double modalPrice,
      String market,
      String state,
      String district,
      String? unit,
      DateTime? arrivalDate,
      DateTime? recordedAt});
}

/// @nodoc
class _$MarketPriceModelCopyWithImpl<$Res, $Val extends MarketPriceModel>
    implements $MarketPriceModelCopyWith<$Res> {
  _$MarketPriceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cropName = null,
    Object? variety = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? modalPrice = null,
    Object? market = null,
    Object? state = null,
    Object? district = null,
    Object? unit = freezed,
    Object? arrivalDate = freezed,
    Object? recordedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      variety: null == variety
          ? _value.variety
          : variety // ignore: cast_nullable_to_non_nullable
              as String,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      modalPrice: null == modalPrice
          ? _value.modalPrice
          : modalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      market: null == market
          ? _value.market
          : market // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalDate: freezed == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordedAt: freezed == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketPriceModelImplCopyWith<$Res>
    implements $MarketPriceModelCopyWith<$Res> {
  factory _$$MarketPriceModelImplCopyWith(_$MarketPriceModelImpl value,
          $Res Function(_$MarketPriceModelImpl) then) =
      __$$MarketPriceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String cropName,
      String variety,
      double minPrice,
      double maxPrice,
      double modalPrice,
      String market,
      String state,
      String district,
      String? unit,
      DateTime? arrivalDate,
      DateTime? recordedAt});
}

/// @nodoc
class __$$MarketPriceModelImplCopyWithImpl<$Res>
    extends _$MarketPriceModelCopyWithImpl<$Res, _$MarketPriceModelImpl>
    implements _$$MarketPriceModelImplCopyWith<$Res> {
  __$$MarketPriceModelImplCopyWithImpl(_$MarketPriceModelImpl _value,
      $Res Function(_$MarketPriceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cropName = null,
    Object? variety = null,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? modalPrice = null,
    Object? market = null,
    Object? state = null,
    Object? district = null,
    Object? unit = freezed,
    Object? arrivalDate = freezed,
    Object? recordedAt = freezed,
  }) {
    return _then(_$MarketPriceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      variety: null == variety
          ? _value.variety
          : variety // ignore: cast_nullable_to_non_nullable
              as String,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      modalPrice: null == modalPrice
          ? _value.modalPrice
          : modalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      market: null == market
          ? _value.market
          : market // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      arrivalDate: freezed == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordedAt: freezed == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketPriceModelImpl implements _MarketPriceModel {
  const _$MarketPriceModelImpl(
      {required this.id,
      required this.cropName,
      required this.variety,
      required this.minPrice,
      required this.maxPrice,
      required this.modalPrice,
      required this.market,
      required this.state,
      required this.district,
      this.unit,
      this.arrivalDate,
      this.recordedAt});

  factory _$MarketPriceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketPriceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String cropName;
  @override
  final String variety;
  @override
  final double minPrice;
// per quintal
  @override
  final double maxPrice;
  @override
  final double modalPrice;
  @override
  final String market;
  @override
  final String state;
  @override
  final String district;
  @override
  final String? unit;
  @override
  final DateTime? arrivalDate;
  @override
  final DateTime? recordedAt;

  @override
  String toString() {
    return 'MarketPriceModel(id: $id, cropName: $cropName, variety: $variety, minPrice: $minPrice, maxPrice: $maxPrice, modalPrice: $modalPrice, market: $market, state: $state, district: $district, unit: $unit, arrivalDate: $arrivalDate, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketPriceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            (identical(other.variety, variety) || other.variety == variety) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.modalPrice, modalPrice) ||
                other.modalPrice == modalPrice) &&
            (identical(other.market, market) || other.market == market) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.arrivalDate, arrivalDate) ||
                other.arrivalDate == arrivalDate) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      cropName,
      variety,
      minPrice,
      maxPrice,
      modalPrice,
      market,
      state,
      district,
      unit,
      arrivalDate,
      recordedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketPriceModelImplCopyWith<_$MarketPriceModelImpl> get copyWith =>
      __$$MarketPriceModelImplCopyWithImpl<_$MarketPriceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketPriceModelImplToJson(
      this,
    );
  }
}

abstract class _MarketPriceModel implements MarketPriceModel {
  const factory _MarketPriceModel(
      {required final String id,
      required final String cropName,
      required final String variety,
      required final double minPrice,
      required final double maxPrice,
      required final double modalPrice,
      required final String market,
      required final String state,
      required final String district,
      final String? unit,
      final DateTime? arrivalDate,
      final DateTime? recordedAt}) = _$MarketPriceModelImpl;

  factory _MarketPriceModel.fromJson(Map<String, dynamic> json) =
      _$MarketPriceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get cropName;
  @override
  String get variety;
  @override
  double get minPrice;
  @override // per quintal
  double get maxPrice;
  @override
  double get modalPrice;
  @override
  String get market;
  @override
  String get state;
  @override
  String get district;
  @override
  String? get unit;
  @override
  DateTime? get arrivalDate;
  @override
  DateTime? get recordedAt;
  @override
  @JsonKey(ignore: true)
  _$$MarketPriceModelImplCopyWith<_$MarketPriceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceTrend _$PriceTrendFromJson(Map<String, dynamic> json) {
  return _PriceTrend.fromJson(json);
}

/// @nodoc
mixin _$PriceTrend {
  String get cropName => throw _privateConstructorUsedError;
  List<PricePoint> get priceHistory => throw _privateConstructorUsedError;
  String? get trend =>
      throw _privateConstructorUsedError; // rising, falling, stable
  double? get percentageChange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceTrendCopyWith<PriceTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceTrendCopyWith<$Res> {
  factory $PriceTrendCopyWith(
          PriceTrend value, $Res Function(PriceTrend) then) =
      _$PriceTrendCopyWithImpl<$Res, PriceTrend>;
  @useResult
  $Res call(
      {String cropName,
      List<PricePoint> priceHistory,
      String? trend,
      double? percentageChange});
}

/// @nodoc
class _$PriceTrendCopyWithImpl<$Res, $Val extends PriceTrend>
    implements $PriceTrendCopyWith<$Res> {
  _$PriceTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cropName = null,
    Object? priceHistory = null,
    Object? trend = freezed,
    Object? percentageChange = freezed,
  }) {
    return _then(_value.copyWith(
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      priceHistory: null == priceHistory
          ? _value.priceHistory
          : priceHistory // ignore: cast_nullable_to_non_nullable
              as List<PricePoint>,
      trend: freezed == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String?,
      percentageChange: freezed == percentageChange
          ? _value.percentageChange
          : percentageChange // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceTrendImplCopyWith<$Res>
    implements $PriceTrendCopyWith<$Res> {
  factory _$$PriceTrendImplCopyWith(
          _$PriceTrendImpl value, $Res Function(_$PriceTrendImpl) then) =
      __$$PriceTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cropName,
      List<PricePoint> priceHistory,
      String? trend,
      double? percentageChange});
}

/// @nodoc
class __$$PriceTrendImplCopyWithImpl<$Res>
    extends _$PriceTrendCopyWithImpl<$Res, _$PriceTrendImpl>
    implements _$$PriceTrendImplCopyWith<$Res> {
  __$$PriceTrendImplCopyWithImpl(
      _$PriceTrendImpl _value, $Res Function(_$PriceTrendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cropName = null,
    Object? priceHistory = null,
    Object? trend = freezed,
    Object? percentageChange = freezed,
  }) {
    return _then(_$PriceTrendImpl(
      cropName: null == cropName
          ? _value.cropName
          : cropName // ignore: cast_nullable_to_non_nullable
              as String,
      priceHistory: null == priceHistory
          ? _value._priceHistory
          : priceHistory // ignore: cast_nullable_to_non_nullable
              as List<PricePoint>,
      trend: freezed == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as String?,
      percentageChange: freezed == percentageChange
          ? _value.percentageChange
          : percentageChange // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceTrendImpl implements _PriceTrend {
  const _$PriceTrendImpl(
      {required this.cropName,
      required final List<PricePoint> priceHistory,
      this.trend,
      this.percentageChange})
      : _priceHistory = priceHistory;

  factory _$PriceTrendImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceTrendImplFromJson(json);

  @override
  final String cropName;
  final List<PricePoint> _priceHistory;
  @override
  List<PricePoint> get priceHistory {
    if (_priceHistory is EqualUnmodifiableListView) return _priceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceHistory);
  }

  @override
  final String? trend;
// rising, falling, stable
  @override
  final double? percentageChange;

  @override
  String toString() {
    return 'PriceTrend(cropName: $cropName, priceHistory: $priceHistory, trend: $trend, percentageChange: $percentageChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceTrendImpl &&
            (identical(other.cropName, cropName) ||
                other.cropName == cropName) &&
            const DeepCollectionEquality()
                .equals(other._priceHistory, _priceHistory) &&
            (identical(other.trend, trend) || other.trend == trend) &&
            (identical(other.percentageChange, percentageChange) ||
                other.percentageChange == percentageChange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cropName,
      const DeepCollectionEquality().hash(_priceHistory),
      trend,
      percentageChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceTrendImplCopyWith<_$PriceTrendImpl> get copyWith =>
      __$$PriceTrendImplCopyWithImpl<_$PriceTrendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceTrendImplToJson(
      this,
    );
  }
}

abstract class _PriceTrend implements PriceTrend {
  const factory _PriceTrend(
      {required final String cropName,
      required final List<PricePoint> priceHistory,
      final String? trend,
      final double? percentageChange}) = _$PriceTrendImpl;

  factory _PriceTrend.fromJson(Map<String, dynamic> json) =
      _$PriceTrendImpl.fromJson;

  @override
  String get cropName;
  @override
  List<PricePoint> get priceHistory;
  @override
  String? get trend;
  @override // rising, falling, stable
  double? get percentageChange;
  @override
  @JsonKey(ignore: true)
  _$$PriceTrendImplCopyWith<_$PriceTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PricePoint _$PricePointFromJson(Map<String, dynamic> json) {
  return _PricePoint.fromJson(json);
}

/// @nodoc
mixin _$PricePoint {
  DateTime get date => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PricePointCopyWith<PricePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricePointCopyWith<$Res> {
  factory $PricePointCopyWith(
          PricePoint value, $Res Function(PricePoint) then) =
      _$PricePointCopyWithImpl<$Res, PricePoint>;
  @useResult
  $Res call({DateTime date, double price});
}

/// @nodoc
class _$PricePointCopyWithImpl<$Res, $Val extends PricePoint>
    implements $PricePointCopyWith<$Res> {
  _$PricePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PricePointImplCopyWith<$Res>
    implements $PricePointCopyWith<$Res> {
  factory _$$PricePointImplCopyWith(
          _$PricePointImpl value, $Res Function(_$PricePointImpl) then) =
      __$$PricePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, double price});
}

/// @nodoc
class __$$PricePointImplCopyWithImpl<$Res>
    extends _$PricePointCopyWithImpl<$Res, _$PricePointImpl>
    implements _$$PricePointImplCopyWith<$Res> {
  __$$PricePointImplCopyWithImpl(
      _$PricePointImpl _value, $Res Function(_$PricePointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? price = null,
  }) {
    return _then(_$PricePointImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PricePointImpl implements _PricePoint {
  const _$PricePointImpl({required this.date, required this.price});

  factory _$PricePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricePointImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double price;

  @override
  String toString() {
    return 'PricePoint(date: $date, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricePointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PricePointImplCopyWith<_$PricePointImpl> get copyWith =>
      __$$PricePointImplCopyWithImpl<_$PricePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricePointImplToJson(
      this,
    );
  }
}

abstract class _PricePoint implements PricePoint {
  const factory _PricePoint(
      {required final DateTime date,
      required final double price}) = _$PricePointImpl;

  factory _PricePoint.fromJson(Map<String, dynamic> json) =
      _$PricePointImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$PricePointImplCopyWith<_$PricePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
