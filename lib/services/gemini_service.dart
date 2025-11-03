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
}
