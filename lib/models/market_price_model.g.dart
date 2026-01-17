// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketPriceModelImpl _$$MarketPriceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MarketPriceModelImpl(
      id: json['id'] as String,
      cropName: json['cropName'] as String,
      variety: json['variety'] as String,
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
      modalPrice: (json['modalPrice'] as num).toDouble(),
      market: json['market'] as String,
      state: json['state'] as String,
      district: json['district'] as String,
      unit: json['unit'] as String?,
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      recordedAt: json['recordedAt'] == null
          ? null
          : DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$MarketPriceModelImplToJson(
        _$MarketPriceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cropName': instance.cropName,
      'variety': instance.variety,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'modalPrice': instance.modalPrice,
      'market': instance.market,
      'state': instance.state,
      'district': instance.district,
      'unit': instance.unit,
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'recordedAt': instance.recordedAt?.toIso8601String(),
    };

_$PriceTrendImpl _$$PriceTrendImplFromJson(Map<String, dynamic> json) =>
    _$PriceTrendImpl(
      cropName: json['cropName'] as String,
      priceHistory: (json['priceHistory'] as List<dynamic>)
          .map((e) => PricePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      trend: json['trend'] as String?,
      percentageChange: (json['percentageChange'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PriceTrendImplToJson(_$PriceTrendImpl instance) =>
    <String, dynamic>{
      'cropName': instance.cropName,
      'priceHistory': instance.priceHistory,
      'trend': instance.trend,
      'percentageChange': instance.percentageChange,
    };

_$PricePointImpl _$$PricePointImplFromJson(Map<String, dynamic> json) =>
    _$PricePointImpl(
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$PricePointImplToJson(_$PricePointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'price': instance.price,
    };
