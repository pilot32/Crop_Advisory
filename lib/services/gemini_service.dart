import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _logger = Logger();

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

/// Custom exception for rate limiting
class RateLimitException implements Exception {
  final String message;
  final int remaining;
  RateLimitException(this.message, {this.remaining = 0});
  @override
  String toString() => message;
}

/// Gemini AI Service — calls Supabase Edge Functions instead of direct API.
///
/// All AI features (chat, pest analysis, crop advisory, fertilizer,
/// market prices, weather advisory, etc.) go through a single
/// `ask-ai` edge function. API key stays server-side.
class GeminiService {
  final Logger _logger = Logger();

  /// Core method — all other methods funnel through this
  Future<String> _askAi({
    required String prompt,
    List<int>? imageBytes,
    String? mimeType,
  }) async {
    try {
      final body = <String, dynamic>{
        'prompt': prompt,
      };

      // Attach image if provided (for vision tasks)
      if (imageBytes != null) {
        body['imageData'] = base64Encode(imageBytes);
        body['mimeType'] = mimeType ?? 'image/jpeg';
      }

      final response = await Supabase.instance.client.functions.invoke(
        'ask-ai',
        body: body,
      );

      final data = response.data;
      if (response.status != null && response.status! >= 400) {
        final errorMsg = data?['error'] ?? 'Request failed';
        if (response.status == 429) {
          throw RateLimitException(
            data?['message'] ?? 'Daily limit reached. Try again tomorrow.',
            remaining: data?['remaining'] ?? 0,
          );
        }
        throw Exception(errorMsg);
      }

      final text = data?['text'];
      if (text == null || text.toString().isEmpty) {
        throw Exception('Empty response from AI');
      }

      return text.toString();
    } on RateLimitException {
      rethrow;
    } catch (e) {
      _logger.e('AI request failed: $e');
      rethrow;
    }
  }

  // ============================================================================
  // CHAT
  // ============================================================================

  /// Send a chat message
  Future<String> sendMessage({
    required String message,
    String language = 'English',
    String? context,
  }) {
    final prompt = StringBuffer();
    prompt.writeln('You are an AI assistant specialized in Indian agriculture and farming.');
    prompt.writeln('You help small and marginal farmers with crop advisory, pest management, '
        'fertilizer recommendations, and general farming questions.');
    if (context != null && context.isNotEmpty) {
      prompt.writeln('\nContext: $context');
    }
    if (language != 'English') {
      prompt.writeln('\nRespond in $language language.');
    }
    prompt.writeln('\nUser Question: $message');
    return _askAi(prompt: prompt.toString().trim());
  }

  /// Send message with chat history for context
  Future<String> sendChatMessage({
    required String session,
    required String message,
    List<Map<String, String>>? history,
    String language = 'English',
  }) {
    String? context;
    if (history != null && history.isNotEmpty) {
      final recent = history.take(6).map((m) => "${m['role']}: ${m['content']}").join("\n");
      context = 'Previous conversation:\n$recent\n'
          'This is part of an ongoing conversation about farming.';
    }
    return sendMessage(message: message, language: language, context: context);
  }

  /// Stream is not supported via edge functions — falls back to single response
  Stream<String> streamMessage({
    required String message,
    String language = 'English',
  }) async* {
    final response = await sendMessage(message: message, language: language);
    yield response;
  }

  // ============================================================================
  // CROP ADVISORY
  // ============================================================================

  Future<String> getCropAdvisory({
    required String cropType,
    required String soilType,
    required String season,
    required String location,
    String language = 'English',
  }) {
    const prompt = '''
You are an expert agricultural advisor for Indian farmers.

Crop: {cropType}
Soil Type: {soilType}
Season: {season}
Location: {location}

Provide:
1. Best practices for this crop in current season
2. Fertilizer recommendations with dosage
3. Irrigation schedule and water management
4. Common pests/diseases to watch for
5. Approximate harvest timeline
6. Expected yield estimates
7. Post-harvest handling tips

Make the advice practical, localized, and easy for small farmers to implement.''';

    return _askAi(prompt: prompt
        .replaceAll('{cropType}', cropType)
        .replaceAll('{soilType}', soilType)
        .replaceAll('{season}', season)
        .replaceAll('{location}', location));
  }

  // ============================================================================
  // FERTILIZER
  // ============================================================================

  Future<String> getFertilizerRecommendation({
    required String cropType,
    required Map<String, dynamic> soilHealthData,
    String language = 'English',
  }) {
    final prompt = '''
You are a soil health and fertilizer expert.

Crop: $cropType
Soil Data: ${soilHealthData.toString()}

Based on the soil test results, recommend:
1. Type of fertilizers needed (NPK ratio)
2. Quantity per acre/hectare
3. Application timing and method
4. Organic alternatives if available
5. Precautions and best practices

Keep recommendations practical and cost-effective for small farmers.''';
    return _askAi(prompt: prompt);
  }

  Future<String> calculateFertilizerRequirement({
    required String cropType,
    required double areaInAcres,
    Map<String, dynamic>? soilData,
    String language = 'English',
  }) {
    final prompt = '''
You are a fertilizer calculation expert.

Crop: $cropType
Area: $areaInAcres acres
Soil Data: ${soilData?.toString() ?? 'Not available'}

Provide:
1. NPK quantities (in kg) for the total area
2. Breakdown by application stage (basal, top dressing)
3. Estimated cost (approximate for Indian market)
4. Application schedule
5. Organic alternatives if available

Format the response clearly with quantities and timing.''';
    return _askAi(prompt: prompt);
  }

  // ============================================================================
  // PEST / IMAGE ANALYSIS
  // ============================================================================

  Future<String> analyzePestImage({
    required List<int> imageBytes,
    required String mimeType,
    String language = 'English',
  }) {
    const prompt = '''
You are an expert in plant pathology and pest management for Indian agriculture.

Identify:
1. Pest or disease affecting the plant (if any)
2. Severity level (mild, moderate, severe)
3. Affected plant parts
4. Recommended treatments (organic and chemical)
5. Preventive measures
6. Timeline for recovery
7. Whether farmer should seek immediate professional help

If the image does not show any pest or disease, provide general plant health assessment.''';
    return _askAi(prompt: prompt, imageBytes: imageBytes, mimeType: mimeType);
  }

  Future<String> analyzeCropHealth({
    required List<int> imageBytes,
    required String mimeType,
    required String cropType,
    String language = 'English',
  }) {
    final prompt = '''
You are an expert agronomist. Analyze this $cropType image.

Assess:
1. Overall crop health status
2. Growth stage
3. Any visible deficiencies (nutrients, water)
4. Leaf color and condition
5. Recommendations for improvement
6. Estimated days to harvest (if applicable)

Provide actionable insights for the farmer.''';
    return _askAi(prompt: prompt, imageBytes: imageBytes, mimeType: mimeType);
  }

  Future<String> checkHarvestReadiness({
    required List<int> imageBytes,
    required String mimeType,
    required String cropType,
    String language = 'English',
  }) {
    final prompt = '''
You are a harvest timing expert. Analyze this $cropType image.

Determine:
1. Is the crop ready for harvest? (Yes/No)
2. Maturity percentage (0-100%)
3. Indicators observed (color, size, texture)
4. Days remaining if not ready
5. Optimal harvest window
6. Post-harvest handling instructions
7. Expected quality grade

Be precise and practical.''';
    return _askAi(prompt: prompt, imageBytes: imageBytes, mimeType: mimeType);
  }

  // ============================================================================
  // MARKET PRICES
  // ============================================================================

  Future<String> analyzeMarketPrices({
    required String cropType,
    required List<Map<String, dynamic>> marketPrices,
    required String currentLocation,
    String language = 'English',
  }) {
    final prompt = '''
You are a market analyst.

Crop: $cropType
Your Location: $currentLocation
Market Prices: ${marketPrices.toString()}

Provide:
1. Best market to sell (considering price and distance)
2. Price trends (rising/falling)
3. Best time to sell
4. Transportation cost considerations
5. Alternative markets if main market is far
6. Negotiation tips

Help farmer maximize profit.''';
    return _askAi(prompt: prompt);
  }

  // ============================================================================
  // SOIL HEALTH
  // ============================================================================

  Future<String> analyzeSoilHealth({
    Map<String, dynamic>? soilTestData,
    List<int>? soilImageBytes,
    String? mimeType,
    String language = 'English',
  }) {
    final prompt = '''
You are a soil scientist.

 ${soilTestData != null ? 'Test Results: ${soilTestData.toString()}' : 'Analyze visual appearance'}

Provide:
1. Overall soil health rating
2. Nutrient status (NPK, micronutrients)
3. pH level and corrections needed
4. Organic matter content
5. Recommendations for improvement
6. Suitable crops for this soil
7. Soil amendment suggestions

Make practical for small farmers.''';

    return _askAi(
      prompt: prompt,
      imageBytes: soilImageBytes,
      mimeType: mimeType,
    );
  }

  // ============================================================================
  // WEATHER
  // ============================================================================

  Future<String> getWeatherAdvisory({
    required Map<String, dynamic> weatherData,
    required String cropType,
    required String growthStage,
    String language = 'English',
  }) {
    final prompt = '''
You are a weather-agriculture expert.

Weather: ${weatherData.toString()}
Crop: $cropType
Growth Stage: $growthStage

Advise:
1. Impact of current weather on crop
2. Actions to take (irrigation, protection, etc.)
3. Pest/disease risks in this weather
4. Harvesting considerations if applicable
5. Precautions for next 3-5 days

Be specific and actionable.''';
    return _askAi(prompt: prompt);
  }

  Future<String> calculateWaterRequirement({
    required String cropType,
    required String growthStage,
    required double areaInAcres,
    required Map<String, dynamic> weatherData,
    String language = 'English',
  }) {
    final prompt = '''
You are an irrigation expert.

Crop: $cropType
Growth Stage: $growthStage
Area: $areaInAcres acres
Weather: ${weatherData.toString()}

Provide:
1. Daily water requirement (liters or gallons)
2. Irrigation frequency
3. Best time for irrigation
4. Water-saving tips
5. Adjustments based on weather conditions

Keep recommendations practical for small farmers.''';
    return _askAi(prompt: prompt);
  }

  // ============================================================================
  // CROP PLANNING
  // ============================================================================

  Future<String> getSeasonalCropSuggestions({
    required String location,
    required String currentMonth,
    required String soilType,
    String language = 'English',
  }) {
    final prompt = '''
You are an agricultural planning expert.

Location: $location
Current Month: $currentMonth
Soil Type: $soilType

Provide:
1. Top 5 recommended crops for this season
2. Reason for each recommendation
3. Expected yield and profit potential
4. Market demand trends
5. Risk factors to consider
6. Input costs estimate

Focus on crops suitable for Indian small farmers.''';
    return _askAi(prompt: prompt);
  }

  Future<String> estimateInputCosts({
    required String cropType,
    required double areaInAcres,
    required String location,
    String language = 'English',
  }) {
    final prompt = '''
You are a farm economics expert.

Crop: $cropType
Area: $areaInAcres acres
Location: $location

Provide detailed breakdown:
1. Seeds/Seedlings cost
2. Fertilizers (organic and chemical)
3. Pesticides/Herbicides
4. Labor costs
5. Irrigation/Water costs
6. Equipment/Tools
7. Total estimated cost
8. Expected revenue and profit margin

Use realistic prices for $location region.''';
    return _askAi(prompt: prompt);
  }

  Future<String> generateCropCalendar({
    required String cropType,
    required DateTime sowingDate,
    required String location,
    String language = 'English',
  }) {
    final prompt = '''
You are a crop planning expert.

Crop: $cropType
Sowing Date: ${sowingDate.toLocal()}
Location: $location

Provide timeline with:
1. Key growth stages with dates
2. Irrigation schedule
3. Fertilizer application dates
4. Pest control spray dates
5. Expected harvest date
6. Weekly activities breakdown

Format as a clear calendar farmers can follow.''';
    return _askAi(prompt: prompt);
  }

  Future<String> generateCropFAQ({
    required String cropType,
    required String region,
    String language = 'English',
  }) {
    final prompt = '''
Create comprehensive FAQ for $cropType farming.

Region: $region

Include 20-30 common questions covering:
1. Seed selection and sowing
2. Irrigation and water management
3. Fertilizer and nutrition
4. Pest and disease management
5. Harvesting and post-harvest
6. Market and selling
7. Common problems and solutions

Format: Q: [Question]\nA: [Detailed Answer]\n\n''';
    return _askAi(prompt: prompt);
  }

  Future<Map<String, String>> translateToVernacular({
    required List<String> terms,
    required String targetLanguage,
  }) async {
    final prompt = '''
Translate these agricultural terms to $targetLanguage (Indian language).
Provide both scientific and common local names.

Terms: ${terms.join(', ')}

Format response as JSON:
{
  "term1": "vernacular translation",
  "term2": "vernacular translation"
}''';

    final response = await _askAi(prompt: prompt);
    return {'translation': response};
  }
}