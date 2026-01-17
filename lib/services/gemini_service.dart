/// Gemini AI Service
/// 
/// This service handles all interactions with Google's Gemini AI API including:
/// - Chat conversations
/// - Image analysis for pest detection
/// - Crop advisory recommendations
/// - Multilingual support

import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import '../core/config/env_config.dart';

part 'gemini_service.g.dart';

/// Gemini model provider
/// 
/// Provides access to the Gemini generative model with API key from environment.
/// This is a singleton that persists for the lifetime of the app.
@Riverpod(keepAlive: true)
GenerativeModel geminiModel(GeminiModelRef ref) {
  final config = ref.watch(envConfigProvider);
  
  return GenerativeModel(
    model: 'gemini-pro',
    apiKey: config.geminiApiKey,
  );
}

/// Gemini vision model provider for image analysis
/// 
/// Provides access to Gemini Pro Vision model for image-based tasks like pest detection.
@Riverpod(keepAlive: true)
GenerativeModel geminiVisionModel(GeminiVisionModelRef ref) {
  final config = ref.watch(envConfigProvider);
  
  return GenerativeModel(
    model: 'gemini-pro-vision',
    apiKey: config.geminiApiKey,
  );
}

/// Gemini service provider
/// 
/// Provides the GeminiService instance with dependency injection.
@Riverpod(keepAlive: true)
GeminiService geminiService(GeminiServiceRef ref) {
  final model = ref.watch(geminiModelProvider);
  final visionModel = ref.watch(geminiVisionModelProvider);
  return GeminiService(model, visionModel);
}

/// Service class for Gemini AI operations
class GeminiService {
  /// Gemini text model instance
  final GenerativeModel _model;
  
  /// Gemini vision model instance for image analysis
  final GenerativeModel _visionModel;
  
  /// Logger instance for debugging and error tracking
  final Logger _logger = Logger();

  GeminiService(this._model, this._visionModel);

  // ============================================================================
  // CHAT METHODS
  // ============================================================================

  /// Send a message and get AI response
  /// 
  /// Parameters:
  /// - [message]: User's text message
  /// - [language]: Target language for response (default: English)
  /// - [context]: Additional context for better responses (optional)
  /// 
  /// Returns: AI generated response text
  /// Throws: Exception if request fails
  Future<String> sendMessage({
    required String message,
    String language = 'English',
    String? context,
  }) async {
    try {
      _logger.i('Sending message to Gemini AI');
      
      // Build the prompt with context and language preference
      final prompt = _buildPrompt(
        message: message,
        language: language,
        context: context,
      );
      
      // Generate content
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty response from AI');
      }
      
      _logger.i('Received AI response successfully');
      return text;
    } catch (e) {
      _logger.e('Error sending message to AI: $e');
      rethrow;
    }
  }

  /// Start a chat conversation with message history
  /// 
  /// Parameters:
  /// - [history]: Previous conversation messages for context
  /// 
  /// Returns: ChatSession instance for continued conversation
  ChatSession startChat({List<Content>? history}) {
    _logger.i('Starting new chat session');
    return _model.startChat(history: history);
  }

  /// Send a message in an ongoing chat session
  /// 
  /// Parameters:
  /// - [session]: Active chat session
  /// - [message]: User's message
  /// - [language]: Target language for response
  /// 
  /// Returns: AI response text
  /// Throws: Exception if request fails
  Future<String> sendChatMessage({
    required ChatSession session,
    required String message,
    String language = 'English',
  }) async {
    try {
      _logger.i('Sending message in chat session');
      
      final prompt = _buildPrompt(
        message: message,
        language: language,
        context: 'This is part of an ongoing conversation about farming and crop advisory.',
      );
      
      final response = await session.sendMessage(Content.text(prompt));
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty response from AI');
      }
      
      _logger.i('Received chat response successfully');
      return text;
    } catch (e) {
      _logger.e('Error in chat session: $e');
      rethrow;
    }
  }

  // ============================================================================
  // CROP ADVISORY METHODS
  // ============================================================================

  /// Get crop advisory recommendations based on various factors
  /// 
  /// Parameters:
  /// - [cropType]: Type of crop (e.g., Rice, Wheat, Cotton)
  /// - [soilType]: Type of soil (e.g., Clay, Sandy, Loamy)
  /// - [season]: Current season or month
  /// - [location]: Farmer's location (district/state)
  /// - [language]: Response language preference
  /// 
  /// Returns: Detailed crop advisory text
  /// Throws: Exception if request fails
  Future<String> getCropAdvisory({
    required String cropType,
    required String soilType,
    required String season,
    required String location,
    String language = 'English',
  }) async {
    try {
      _logger.i('Getting crop advisory for $cropType');
      
      final prompt = '''
You are an expert agricultural advisor for Indian farmers. Provide detailed crop advisory in $language language.

Crop: $cropType
Soil Type: $soilType
Season: $season
Location: $location

Please provide:
1. Best practices for this crop in current season
2. Fertilizer recommendations with dosage
3. Irrigation schedule and water management
4. Common pests/diseases to watch for
5. Approximate harvest timeline
6. Expected yield estimates
7. Post-harvest handling tips

Make the advice practical, localized, and easy for small farmers to implement.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty advisory response');
      }
      
      _logger.i('Crop advisory generated successfully');
      return text;
    } catch (e) {
      _logger.e('Error generating crop advisory: $e');
      rethrow;
    }
  }

  /// Get fertilizer recommendations
  /// 
  /// Parameters:
  /// - [cropType]: Type of crop
  /// - [soilHealthData]: Map containing soil test results (N, P, K, pH, etc.)
  /// - [language]: Response language
  /// 
  /// Returns: Fertilizer recommendation text
  Future<String> getFertilizerRecommendation({
    required String cropType,
    required Map<String, dynamic> soilHealthData,
    String language = 'English',
  }) async {
    try {
      _logger.i('Getting fertilizer recommendations');
      
      final prompt = '''
You are a soil health and fertilizer expert. Provide fertilizer recommendations in $language language.

Crop: $cropType
Soil Data: ${soilHealthData.toString()}

Based on the soil test results, recommend:
1. Type of fertilizers needed (NPK ratio)
2. Quantity per acre/hectare
3. Application timing and method
4. Organic alternatives if available
5. Precautions and best practices

Keep recommendations practical and cost-effective for small farmers.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty fertilizer recommendation');
      }
      
      _logger.i('Fertilizer recommendation generated');
      return text;
    } catch (e) {
      _logger.e('Error generating fertilizer recommendation: $e');
      rethrow;
    }
  }

  // ============================================================================
  // IMAGE ANALYSIS METHODS
  // ============================================================================

  /// Analyze an image for pest or disease detection
  /// 
  /// Parameters:
  /// - [imageBytes]: Image data as bytes
  /// - [mimeType]: Image MIME type (e.g., 'image/jpeg')
  /// - [language]: Response language
  /// 
  /// Returns: Analysis result with pest/disease identification and treatment
  /// Throws: Exception if analysis fails
  Future<String> analyzePestImage({
    required List<int> imageBytes,
    required String mimeType,
    String language = 'English',
  }) async {
    try {
      _logger.i('Analyzing pest/disease image');
      
      final prompt = '''
You are an expert in plant pathology and pest management for Indian agriculture. 
Analyze this image and respond in $language language.

Identify:
1. Pest or disease affecting the plant (if any)
2. Severity level (mild, moderate, severe)
3. Affected plant parts
4. Recommended treatments (organic and chemical)
5. Preventive measures
6. Timeline for recovery
7. Whether farmer should seek immediate professional help

If the image does not show any pest or disease, provide general plant health assessment.
''';
      
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(mimeType, Uint8List.fromList(imageBytes)),
        ])
      ];
      
      final response = await _visionModel.generateContent(content);
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty analysis response');
      }
      
      _logger.i('Image analysis completed successfully');
      return text;
    } catch (e) {
      _logger.e('Error analyzing image: $e');
      rethrow;
    }
  }

  /// Analyze crop health from image
  /// 
  /// Parameters:
  /// - [imageBytes]: Image data as bytes
  /// - [mimeType]: Image MIME type
  /// - [cropType]: Type of crop in image
  /// - [language]: Response language
  /// 
  /// Returns: Crop health assessment
  Future<String> analyzeCropHealth({
    required List<int> imageBytes,
    required String mimeType,
    required String cropType,
    String language = 'English',
  }) async {
    try {
      _logger.i('Analyzing crop health for $cropType');
      
      final prompt = '''
You are an expert agronomist. Analyze this $cropType image and respond in $language language.

Assess:
1. Overall crop health status
2. Growth stage
3. Any visible deficiencies (nutrients, water)
4. Leaf color and condition
5. Recommendations for improvement
6. Estimated days to harvest (if applicable)

Provide actionable insights for the farmer.
''';
      
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(mimeType, Uint8List.fromList(imageBytes)),
        ])
      ];
      
      final response = await _visionModel.generateContent(content);
      
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty health assessment');
      }
      
      _logger.i('Crop health analysis completed');
      return text;
    } catch (e) {
      _logger.e('Error analyzing crop health: $e');
      rethrow;
    }
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Build a well-formatted prompt with context and language preferences
  /// 
  /// Parameters:
  /// - [message]: User's message
  /// - [language]: Target language
  /// - [context]: Additional context
  /// 
  /// Returns: Formatted prompt string
  String _buildPrompt({
    required String message,
    required String language,
    String? context,
  }) {
    final buffer = StringBuffer();
    
    // Add system context
    buffer.writeln('''
You are an AI assistant specialized in Indian agriculture and farming. 
You help small and marginal farmers with crop advisory, pest management, 
fertilizer recommendations, and general farming questions.
''');
    
    // Add additional context if provided
    if (context != null && context.isNotEmpty) {
      buffer.writeln('\nContext: $context');
    }
    
    // Add language instruction
    if (language != 'English') {
      buffer.writeln('\nRespond in $language language.');
    }
    
    // Add user message
    buffer.writeln('\nUser Question: $message');
    
    return buffer.toString();
  }

  /// Stream response for real-time text generation (for longer responses)
  /// 
  /// Parameters:
  /// - [message]: User's message
  /// - [language]: Response language
  /// 
  /// Returns: Stream of text chunks as they're generated
  Stream<String> streamMessage({
    required String message,
    String language = 'English',
  }) async* {
    try {
      _logger.i('Starting streaming response');
      
      final prompt = _buildPrompt(
        message: message,
        language: language,
        context: null,
      );
      
      final content = [Content.text(prompt)];
      final response = _model.generateContentStream(content);
      
      await for (final chunk in response) {
        final text = chunk.text;
        if (text != null && text.isNotEmpty) {
          yield text;
        }
      }
      
      _logger.i('Streaming completed');
    } catch (e) {
      _logger.e('Error in streaming: $e');
      rethrow;
    }
  }

  // ============================================================================
  // FERTILIZER CALCULATOR
  // ============================================================================

  /// Calculate fertilizer requirements based on crop, area, and soil data
  Future<String> calculateFertilizerRequirement({
    required String cropType,
    required double areaInAcres,
    Map<String, dynamic>? soilData,
    String language = 'English',
  }) async {
    try {
      _logger.i('Calculating fertilizer for $cropType');
      
      final prompt = '''
You are a fertilizer calculation expert. Calculate NPK fertilizer requirements in $language.

Crop: $cropType
Area: $areaInAcres acres
Soil Data: ${soilData?.toString() ?? 'Not available'}

Provide:
1. NPK quantities (in kg) for the total area
2. Breakdown by application stage (basal, top dressing)
3. Estimated cost (approximate for Indian market)
4. Application schedule
5. Organic alternatives if available

Format the response clearly with quantities and timing.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to calculate fertilizer requirement';
    } catch (e) {
      _logger.e('Error calculating fertilizer: $e');
      rethrow;
    }
  }

  // ============================================================================
  // WATER REQUIREMENT TRACKER
  // ============================================================================

  /// Calculate daily water requirements based on crop stage
  Future<String> calculateWaterRequirement({
    required String cropType,
    required String growthStage,
    required double areaInAcres,
    required Map<String, dynamic> weatherData,
    String language = 'English',
  }) async {
    try {
      _logger.i('Calculating water requirement');
      
      final prompt = '''
You are an irrigation expert. Calculate water requirements in $language.

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

Keep recommendations practical for small farmers.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to calculate water requirement';
    } catch (e) {
      _logger.e('Error calculating water requirement: $e');
      rethrow;
    }
  }

  // ============================================================================
  // SEASONAL CROP SUGGESTIONS
  // ============================================================================

  /// Get best crop suggestions for current month and location
  Future<String> getSeasonalCropSuggestions({
    required String location,
    required String currentMonth,
    required String soilType,
    String language = 'English',
  }) async {
    try {
      _logger.i('Getting seasonal crop suggestions');
      
      final prompt = '''
You are an agricultural planning expert. Suggest best crops in $language.

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

Focus on crops suitable for Indian small farmers.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate suggestions';
    } catch (e) {
      _logger.e('Error getting seasonal suggestions: $e');
      rethrow;
    }
  }

  // ============================================================================
  // INPUT COST ESTIMATOR
  // ============================================================================

  /// Estimate input costs for crop planning
  Future<String> estimateInputCosts({
    required String cropType,
    required double areaInAcres,
    required String location,
    String language = 'English',
  }) async {
    try {
      _logger.i('Estimating input costs');
      
      final prompt = '''
You are a farm economics expert. Estimate input costs in $language for Indian market.

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

Use realistic prices for $location region.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to estimate costs';
    } catch (e) {
      _logger.e('Error estimating costs: $e');
      rethrow;
    }
  }

  // ============================================================================
  // HARVEST READINESS CHECKER
  // ============================================================================

  /// Check if crop is ready for harvest from image
  Future<String> checkHarvestReadiness({
    required List<int> imageBytes,
    required String mimeType,
    required String cropType,
    String language = 'English',
  }) async {
    try {
      _logger.i('Checking harvest readiness');
      
      final prompt = '''
You are a harvest timing expert. Analyze this $cropType image in $language.

Determine:
1. Is the crop ready for harvest? (Yes/No)
2. Maturity percentage (0-100%)
3. Indicators observed (color, size, texture)
4. Days remaining if not ready
5. Optimal harvest window
6. Post-harvest handling instructions
7. Expected quality grade

Be precise and practical.
''';
      
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(mimeType, Uint8List.fromList(imageBytes)),
        ])
      ];
      
      final response = await _visionModel.generateContent(content);
      return response.text ?? 'Unable to analyze harvest readiness';
    } catch (e) {
      _logger.e('Error checking harvest readiness: $e');
      rethrow;
    }
  }

  // ============================================================================
  // WEATHER ADVISORY
  // ============================================================================

  /// Generate weather-based farming advisory
  Future<String> getWeatherAdvisory({
    required Map<String, dynamic> weatherData,
    required String cropType,
    required String growthStage,
    String language = 'English',
  }) async {
    try {
      _logger.i('Generating weather advisory');
      
      final prompt = '''
You are a weather-agriculture expert. Provide advisory in $language.

Weather: ${weatherData.toString()}
Crop: $cropType
Growth Stage: $growthStage

Advise:
1. Impact of current weather on crop
2. Actions to take (irrigation, protection, etc.)
3. Pest/disease risks in this weather
4. Harvesting considerations if applicable
5. Precautions for next 3-5 days

Be specific and actionable.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate weather advisory';
    } catch (e) {
      _logger.e('Error generating weather advisory: $e');
      rethrow;
    }
  }

  // ============================================================================
  // MANDI/MARKET DISTANCE & PRICE ANALYSIS
  // ============================================================================

  /// Analyze market prices and provide selling recommendations
  Future<String> analyzeMarketPrices({
    required String cropType,
    required List<Map<String, dynamic>> marketPrices,
    required String currentLocation,
    String language = 'English',
  }) async {
    try {
      _logger.i('Analyzing market prices');
      
      final prompt = '''
You are a market analyst. Analyze prices and advise in $language.

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

Help farmer maximize profit.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to analyze market prices';
    } catch (e) {
      _logger.e('Error analyzing market prices: $e');
      rethrow;
    }
  }

  // ============================================================================
  // SOIL HEALTH ANALYSIS
  // ============================================================================

  /// Analyze soil health from test results or image
  Future<String> analyzeSoilHealth({
    Map<String, dynamic>? soilTestData,
    List<int>? soilImageBytes,
    String? mimeType,
    String language = 'English',
  }) async {
    try {
      _logger.i('Analyzing soil health');
      
      final prompt = '''
You are a soil scientist. Analyze soil health in $language.

${soilTestData != null ? 'Test Results: ${soilTestData.toString()}' : 'Analyze visual appearance'}

Provide:
1. Overall soil health rating
2. Nutrient status (NPK, micronutrients)
3. pH level and corrections needed
4. Organic matter content
5. Recommendations for improvement
6. Suitable crops for this soil
7. Soil amendment suggestions

Make practical for small farmers.
''';
      
      List<Content> content;
      if (soilImageBytes != null && mimeType != null) {
        content = [
          Content.multi([
            TextPart(prompt),
            DataPart(mimeType, Uint8List.fromList(soilImageBytes)),
          ])
        ];
        final response = await _visionModel.generateContent(content);
        return response.text ?? 'Unable to analyze soil';
      } else {
        content = [Content.text(prompt)];
        final response = await _model.generateContent(content);
        return response.text ?? 'Unable to analyze soil';
      }
    } catch (e) {
      _logger.e('Error analyzing soil health: $e');
      rethrow;
    }
  }

  // ============================================================================
  // CROP CALENDAR & REMINDERS
  // ============================================================================

  /// Generate crop calendar with key activities
  Future<String> generateCropCalendar({
    required String cropType,
    required DateTime sowingDate,
    required String location,
    String language = 'English',
  }) async {
    try {
      _logger.i('Generating crop calendar');
      
      final prompt = '''
You are a crop planning expert. Create a detailed calendar in $language.

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

Format as a clear calendar farmers can follow.
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate calendar';
    } catch (e) {
      _logger.e('Error generating crop calendar: $e');
      rethrow;
    }
  }

  // ============================================================================
  // OFFLINE FAQ GENERATION
  // ============================================================================

  /// Generate comprehensive FAQ for specific crop
  Future<String> generateCropFAQ({
    required String cropType,
    required String region,
    String language = 'English',
  }) async {
    try {
      _logger.i('Generating crop FAQ');
      
      final prompt = '''
Create comprehensive FAQ for $cropType farming in $language.

Region: $region

Include 20-30 common questions covering:
1. Seed selection and sowing
2. Irrigation and water management
3. Fertilizer and nutrition
4. Pest and disease management
5. Harvesting and post-harvest
6. Market and selling
7. Common problems and solutions

Format: Q: [Question]\nA: [Detailed Answer]\n\n
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Unable to generate FAQ';
    } catch (e) {
      _logger.e('Error generating FAQ: $e');
      rethrow;
    }
  }

  // ============================================================================
  // VERNACULAR TRANSLATION
  // ============================================================================

  /// Translate crop/pest names to vernacular languages
  Future<Map<String, String>> translateToVernacular({
    required List<String> terms,
    required String targetLanguage,
  }) async {
    try {
      _logger.i('Translating to vernacular');
      
      final prompt = '''
Translate these agricultural terms to $targetLanguage (Indian language).
Provide both scientific and common local names.

Terms: ${terms.join(', ')}

Format response as JSON:
{
  "term1": "vernacular translation",
  "term2": "vernacular translation"
}
''';
      
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      // Parse response (simplified - production would need proper JSON parsing)
      final text = response.text ?? '{}';
      return {'translation': text}; // Simplified return
    } catch (e) {
      _logger.e('Error translating: $e');
      return {};
    }
  }
}
