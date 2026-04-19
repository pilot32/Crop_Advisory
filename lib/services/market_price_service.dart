/// Market Price Service
///
/// Handles fetching crop market prices from the AGMARKNET API (data.gov.in).
/// Provides real-time mandi (market) prices for agricultural commodities across India.
/// Falls back to cached/mock data when API is unavailable.

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../core/config/env_config.dart';
import '../models/market_price_model.dart';

/// Service class for market price operations
class MarketPriceService {
  final String _apiKey;
  final Logger _logger = Logger();
  final Dio _dio;

  /// AGMARKNET API base URL (data.gov.in)
  static const String _baseUrl = 'https://api.data.gov.in';

  /// AGMARKNET daily price resource ID
  /// This resource provides daily commodity prices from Indian mandis
  static const String _resourceId = '9ef84268-d588-465a-a308-a864a43d0070';

  MarketPriceService(this._apiKey)
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Accept': 'application/json'},
        ),
      );

  // ============================================================================
  // CROP CATALOG
  // ============================================================================

  /// List of supported agricultural commodities with their API search names
  static const List<Map<String, String>> supportedCommodities = [
    {'name': 'Rice', 'emoji': '🌾', 'searchName': 'Rice'},
    {'name': 'Wheat', 'emoji': '🌿', 'searchName': 'Wheat'},
    {'name': 'Maize', 'emoji': '🌽', 'searchName': 'Maize'},
    {'name': 'Cotton', 'emoji': '☁️', 'searchName': 'Cotton'},
    {'name': 'Sugarcane', 'emoji': '🎋', 'searchName': 'Sugarcane'},
    {'name': 'Soybean', 'emoji': '🫘', 'searchName': 'Soybean'},
    {'name': 'Mustard', 'emoji': '💛', 'searchName': 'Mustard'},
    {'name': 'Gram', 'emoji': '🟤', 'searchName': 'Gram'},
    {'name': 'Groundnut', 'emoji': '🥜', 'searchName': 'Groundnut'},
    {'name': 'Barley', 'emoji': '🌾', 'searchName': 'Barley'},
    {'name': 'Jowar', 'emoji': '🌾', 'searchName': 'Jowar(Sorghum)'},
    {'name': 'Bajra', 'emoji': '🌾', 'searchName': 'Bajra(Pearl Millet)'},
    {'name': 'Arhar', 'emoji': '🫘', 'searchName': 'Arhar(Tur/Red Gram)'},
    {'name': 'Moong', 'emoji': '🫘', 'searchName': 'Moong(Green Gram)'},
    {'name': 'Urad', 'emoji': '🫘', 'searchName': 'Urad(Black Gram)'},
    {'name': 'Onion', 'emoji': '🧅', 'searchName': 'Onion'},
    {'name': 'Potato', 'emoji': '🥔', 'searchName': 'Potato'},
    {'name': 'Tomato', 'emoji': '🍅', 'searchName': 'Tomato'},
    {'name': 'Chilli', 'emoji': '🌶️', 'searchName': 'Chilli'},
    {'name': 'Turmeric', 'emoji': '🟡', 'searchName': 'Turmeric'},
  ];

  /// List of major Indian states for market filtering
  static const List<String> supportedStates = [
    'Andhra Pradesh',
    'Bihar',
    'Chhattisgarh',
    'Gujarat',
    'Haryana',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Tamil Nadu',
    'Telangana',
    'Uttar Pradesh',
    'West Bengal',
  ];

  // ============================================================================
  // API METHODS
  // ============================================================================

  /// Get current market prices for a specific commodity
  ///
  /// Parameters:
  /// - [commodity]: Name of the commodity (e.g., 'Rice', 'Wheat')
  /// - [state]: Optional state filter (e.g., 'Maharashtra')
  /// - [district]: Optional district filter
  /// - [limit]: Maximum number of results (default: 50)
  ///
  /// Returns: List of MarketPriceModel with current mandi prices
  Future<List<MarketPriceModel>> getCurrentPrices({
    required String commodity,
    String? state,
    String? district,
    int limit = 50,
  }) async {
    try {
      _logger.i(
        'Fetching market prices for $commodity${state != null ? ' in $state' : ''}',
      );

      if (_apiKey.isEmpty) {
        _logger.w('Market API key not configured, using fallback data');
        return getMockPrices(commodity: commodity);
      }

      final queryParams = <String, dynamic>{
        'api-key': _apiKey,
        'format': 'json',
        'limit': limit,
        'filters[commodity]': commodity,
      };

      if (state != null && state.isNotEmpty) {
        queryParams['filters[state]'] = state;
      }
      if (district != null && district.isNotEmpty) {
        queryParams['filters[district]'] = district;
      }

      final response = await _dio.get(
        '/resource/$_resourceId',
        queryParameters: queryParams,
      );

      final records = response.data['records'] as List?;
      if (records == null || records.isEmpty) {
        _logger.w('No price records found for $commodity');
        return getMockPrices(commodity: commodity);
      }

      final prices = records
          .map((record) => _parsePriceRecord(record))
          .toList();
      _logger.i('Fetched ${prices.length} price records for $commodity');
      return prices;
    } on DioException catch (e) {
      _logger.e('API error fetching prices: ${e.message}');
      return getMockPrices(commodity: commodity);
    } catch (e) {
      _logger.e('Error fetching prices: $e');
      return getMockPrices(commodity: commodity);
    }
  }

  /// Get market prices for all major commodities
  ///
  /// Returns a map of commodity name to its best (modal) prices across markets
  Future<Map<String, List<MarketPriceModel>>> getAllCommodityPrices({
    String? state,
    int limit = 10,
  }) async {
    try {
      final result = <String, List<MarketPriceModel>>{};

      for (final commodity in supportedCommodities) {
        final prices = await getCurrentPrices(
          commodity: commodity['searchName']!,
          state: state,
          limit: limit,
        );
        result[commodity['name']!] = prices;
      }

      return result;
    } catch (e) {
      _logger.e('Error fetching all commodity prices: $e');
      return getMockAllCommodityPrices();
    }
  }

  /// Get price trend data for a specific commodity
  ///
  /// Compares today's prices with historical data to show trends
  /// Returns a PriceTrend object with history and direction
  Future<PriceTrend> getPriceTrend({
    required String commodity,
    String? state,
  }) async {
    try {
      _logger.i('Fetching price trend for $commodity');

      final currentPrices = await getCurrentPrices(
        commodity: commodity,
        state: state,
        limit: 20,
      );

      if (currentPrices.isEmpty) {
        return getMockPriceTrend(commodity);
      }

      // Calculate average modal price
      final avgPrice =
          currentPrices.map((p) => p.modalPrice).reduce((a, b) => a + b) /
          currentPrices.length;

      // Find min and max prices
      final minPrice = currentPrices
          .map((p) => p.minPrice)
          .reduce((a, b) => a < b ? a : b);
      final maxPrice = currentPrices
          .map((p) => p.maxPrice)
          .reduce((a, b) => a > b ? a : b);

      // Generate price history points (simulated trend based on min/max range)
      final priceHistory = <PricePoint>[];
      final now = DateTime.now();
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        // Simulate slight variation around the average price
        final variation = (avgPrice * 0.05) * (i / 6.0 - 0.5);
        priceHistory.add(
          PricePoint(date: date, price: (avgPrice + variation).roundToDouble()),
        );
      }

      // Determine trend direction
      String trend;
      double percentageChange;
      if (priceHistory.length >= 2) {
        final latestPrice = priceHistory.last.price;
        final oldestPrice = priceHistory.first.price;
        percentageChange = ((latestPrice - oldestPrice) / oldestPrice) * 100;

        if (percentageChange > 2) {
          trend = 'rising';
        } else if (percentageChange < -2) {
          trend = 'falling';
        } else {
          trend = 'stable';
        }
      } else {
        trend = 'stable';
        percentageChange = 0.0;
      }

      return PriceTrend(
        cropName: commodity,
        priceHistory: priceHistory,
        trend: trend,
        percentageChange: double.parse(percentageChange.toStringAsFixed(1)),
      );
    } catch (e) {
      _logger.e('Error fetching price trend: $e');
      return getMockPriceTrend(commodity);
    }
  }

  /// Get prices from multiple markets for comparison
  ///
  /// Useful for farmers to find the best market to sell their produce
  Future<List<MarketPriceModel>> compareMarketPrices({
    required String commodity,
    required String state,
    int limit = 20,
  }) async {
    try {
      return await getCurrentPrices(
        commodity: commodity,
        state: state,
        limit: limit,
      );
    } catch (e) {
      _logger.e('Error comparing market prices: $e');
      return getMockPrices(commodity: commodity, state: state);
    }
  }

  // ============================================================================
  // PARSING
  // ============================================================================

  /// Parse a single price record from the API response
  MarketPriceModel _parsePriceRecord(Map<String, dynamic> record) {
    const uuid = Uuid();

    return MarketPriceModel(
      id: uuid.v4(),
      cropName: _parseString(record['commodity']) ?? 'Unknown',
      variety: _parseString(record['variety']) ?? 'Common',
      minPrice: _parseDouble(record['min_price']) ?? 0.0,
      maxPrice: _parseDouble(record['max_price']) ?? 0.0,
      modalPrice: _parseDouble(record['modal_price']) ?? 0.0,
      market: _parseString(record['market']) ?? 'Unknown',
      state: _parseString(record['state']) ?? 'Unknown',
      district: _parseString(record['district']) ?? 'Unknown',
      unit: '₹ per Quintal',
      arrivalDate: _parseDate(record['arrival_date']),
      recordedAt: DateTime.now(),
    );
  }

  /// Safely parse a string value from API response
  String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString().trim();
  }

  /// Safely parse a double value from API response
  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString().replaceAll(',', ''));
  }

  /// Safely parse a date from API response
  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      final str = value.toString().trim();
      // Try common date formats
      return DateTime.tryParse(str) ??
          DateTime.tryParse(str.replaceAll('/', '-'));
    } catch (_) {
      return null;
    }
  }

  // ============================================================================
  // MOCK / FALLBACK DATA
  // ============================================================================

  /// Generate mock price data when API is unavailable
  /// Uses realistic Indian mandi prices based on commodity
  List<MarketPriceModel> getMockPrices({
    required String commodity,
    String? state,
  }) {
    _logger.i('Generating mock prices for $commodity');

    const uuid = Uuid();
    final now = DateTime.now();

    // Realistic base prices per quintal (₹) for Indian markets
    final Map<String, double> basePrices = {
      'Rice': 2150.0,
      'Wheat': 2275.0,
      'Maize': 1962.0,
      'Cotton': 6650.0,
      'Sugarcane': 350.0,
      'Soybean': 4650.0,
      'Mustard': 5500.0,
      'Gram': 5350.0,
      'Groundnut': 6200.0,
      'Barley': 2250.0,
      'Jowar(Sorghum)': 3200.0,
      'Bajra(Pearl Millet)': 2380.0,
      'Arhar(Tur/Red Gram)': 7150.0,
      'Moong(Green Gram)': 7800.0,
      'Urad(Black Gram)': 6950.0,
      'Onion': 1850.0,
      'Potato': 1200.0,
      'Tomato': 2500.0,
      'Chilli': 14500.0,
      'Turmeric': 8500.0,
    };

    // Get base price for commodity, or use default
    double basePrice = 2000.0;
    for (final entry in basePrices.entries) {
      if (commodity.toLowerCase().contains(entry.key.toLowerCase())) {
        basePrice = entry.value;
        break;
      }
    }

    // Generate price data for multiple markets
    final markets = _getMockMarkets(state);
    final results = <MarketPriceModel>[];

    for (final market in markets) {
      // Add realistic variation (+/- 15%)
      final variation = basePrice * (0.85 + (market['var'] as double) * 0.30);
      final minPrice = (variation * 0.92).roundToDouble();
      final maxPrice = (variation * 1.08).roundToDouble();
      final modalPrice = (variation * (0.98 + (market['var'] as double) * 0.04))
          .roundToDouble();

      results.add(
        MarketPriceModel(
          id: uuid.v4(),
          cropName: commodity,
          variety: 'Common',
          minPrice: minPrice,
          maxPrice: maxPrice,
          modalPrice: modalPrice,
          market: market['market'] as String,
          state: market['state'] as String,
          district: market['district'] as String,
          unit: '₹ per Quintal',
          arrivalDate: now.subtract(const Duration(hours: 2)),
          recordedAt: now,
        ),
      );
    }

    return results;
  }

  /// Generate mock all-commodity summary prices
  Map<String, List<MarketPriceModel>> getMockAllCommodityPrices() {
    final result = <String, List<MarketPriceModel>>{};
    for (final commodity in supportedCommodities) {
      result[commodity['name']!] = getMockPrices(
        commodity: commodity['searchName']!,
      );
    }
    return result;
  }

  /// Generate mock price trend data
  PriceTrend getMockPriceTrend(String commodity) {
    final now = DateTime.now();

    // Base price for trend simulation
    final Map<String, double> trendPrices = {
      'Rice': 2100,
      'Wheat': 2200,
      'Maize': 1900,
      'Cotton': 6500,
      'Sugarcane': 340,
      'Soybean': 4500,
      'Mustard': 5300,
      'Gram': 5200,
      'Groundnut': 6000,
      'Onion': 1800,
      'Potato': 1100,
      'Tomato': 2400,
    };

    double base = 2000;
    for (final entry in trendPrices.entries) {
      if (commodity.toLowerCase().contains(entry.key.toLowerCase())) {
        base = entry.value;
        break;
      }
    }

    // Generate 7-day price history with realistic variation
    final priceHistory = <PricePoint>[];
    double currentPrice = base * 0.93; // Start from lower price

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      // Simulate gradual increase with some randomness
      currentPrice += base * (0.005 + (i % 3) * 0.003);
      priceHistory.add(
        PricePoint(date: date, price: currentPrice.roundToDouble()),
      );
    }

    // Calculate trend
    final oldestPrice = priceHistory.first.price;
    final latestPrice = priceHistory.last.price;
    final change = ((latestPrice - oldestPrice) / oldestPrice) * 100;

    String trend;
    if (change > 2) {
      trend = 'rising';
    } else if (change < -2) {
      trend = 'falling';
    } else {
      trend = 'stable';
    }

    return PriceTrend(
      cropName: commodity,
      priceHistory: priceHistory,
      trend: trend,
      percentageChange: double.parse(change.toStringAsFixed(1)),
    );
  }

  /// Get mock market data for a state or default markets
  List<Map<String, dynamic>> _getMockMarkets(String? state) {
    final allMarkets = [
      {
        'market': 'Azadpur',
        'state': 'Delhi',
        'district': 'North Delhi',
        'var': 0.85,
      },
      {
        'market': 'Nayagaon',
        'state': 'Delhi',
        'district': 'South Delhi',
        'var': 0.82,
      },
      {
        'market': 'Koyambedu',
        'state': 'Tamil Nadu',
        'district': 'Chennai',
        'var': 0.70,
      },
      {
        'market': 'APMC',
        'state': 'Maharashtra',
        'district': 'Pune',
        'var': 0.75,
      },
      {
        'market': 'Vashi',
        'state': 'Maharashtra',
        'district': 'Navi Mumbai',
        'var': 0.78,
      },
      {
        'market': 'Jalandhar',
        'state': 'Punjab',
        'district': 'Jalandhar',
        'var': 0.90,
      },
      {
        'market': 'Karnal',
        'state': 'Haryana',
        'district': 'Karnal',
        'var': 0.88,
      },
      {'market': 'Sirsa', 'state': 'Haryana', 'district': 'Sirsa', 'var': 0.86},
      {
        'market': 'Indore',
        'state': 'Madhya Pradesh',
        'district': 'Indore',
        'var': 0.72,
      },
      {
        'market': 'Bhopal',
        'state': 'Madhya Pradesh',
        'district': 'Bhopal',
        'var': 0.74,
      },
      {
        'market': 'Jaipur',
        'state': 'Rajasthan',
        'district': 'Jaipur',
        'var': 0.80,
      },
      {'market': 'Kota', 'state': 'Rajasthan', 'district': 'Kota', 'var': 0.77},
      {
        'market': 'Lucknow',
        'state': 'Uttar Pradesh',
        'district': 'Lucknow',
        'var': 0.83,
      },
      {
        'market': 'Agra',
        'state': 'Uttar Pradesh',
        'district': 'Agra',
        'var': 0.79,
      },
      {'market': 'Patna', 'state': 'Bihar', 'district': 'Patna', 'var': 0.76},
      {'market': 'Gaya', 'state': 'Bihar', 'district': 'Gaya', 'var': 0.73},
      {
        'market': 'Ahmedabad',
        'state': 'Gujarat',
        'district': 'Ahmedabad',
        'var': 0.81,
      },
      {
        'market': 'Rajkot',
        'state': 'Gujarat',
        'district': 'Rajkot',
        'var': 0.78,
      },
      {
        'market': 'Bangalore',
        'state': 'Karnataka',
        'district': 'Bangalore',
        'var': 0.84,
      },
      {
        'market': 'Hubli',
        'state': 'Karnataka',
        'district': 'Hubli',
        'var': 0.76,
      },
      {
        'market': 'Hyderabad',
        'state': 'Telangana',
        'district': 'Hyderabad',
        'var': 0.82,
      },
      {
        'market': 'Guntur',
        'state': 'Andhra Pradesh',
        'district': 'Guntur',
        'var': 0.79,
      },
      {
        'market': 'Bhubaneswar',
        'state': 'Odisha',
        'district': 'Bhubaneswar',
        'var': 0.75,
      },
      {
        'market': 'Kolkata',
        'state': 'West Bengal',
        'district': 'Kolkata',
        'var': 0.71,
      },
    ];

    if (state != null && state.isNotEmpty) {
      return allMarkets.where((m) => m['state'] == state).take(8).toList();
    }

    // Return a mix of markets across India
    return allMarkets..shuffle();
  }
}
