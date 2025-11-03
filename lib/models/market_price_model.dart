/// Market Price Model
/// 
/// Represents market price information for crops

import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_price_model.freezed.dart';
part 'market_price_model.g.dart';

@freezed
class MarketPriceModel with _$MarketPriceModel {
  const factory MarketPriceModel({
    required String id,
    required String cropName,
    required String variety,
    required double minPrice, // per quintal
    required double maxPrice,
    required double modalPrice,
    required String market,
    required String state,
    required String district,
    String? unit,
    DateTime? arrivalDate,
    DateTime? recordedAt,
  }) = _MarketPriceModel;

  factory MarketPriceModel.fromJson(Map<String, dynamic> json) =>
      _$MarketPriceModelFromJson(json);
}

@freezed
class PriceTrend with _$PriceTrend {
  const factory PriceTrend({
    required String cropName,
    required List<PricePoint> priceHistory,
    String? trend, // rising, falling, stable
    double? percentageChange,
  }) = _PriceTrend;

  factory PriceTrend.fromJson(Map<String, dynamic> json) =>
      _$PriceTrendFromJson(json);
}

@freezed
class PricePoint with _$PricePoint {
  const factory PricePoint({
    required DateTime date,
    required double price,
  }) = _PricePoint;

  factory PricePoint.fromJson(Map<String, dynamic> json) =>
      _$PricePointFromJson(json);
}
