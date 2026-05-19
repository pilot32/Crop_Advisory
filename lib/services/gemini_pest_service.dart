import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _logger = Logger();

class GeminiPestService {
  final Logger _logger = Logger();

  Future<String> analyzeImage({
    required List<int> imageBytes,
    required String mimeType,
    String language = 'english',
  }) async {
    try {
      _logger.i('Sending pest image to edge function');

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

      final response = await Supabase.instance.client.functions.invoke(
        'ask-ai',
        body: {
          'prompt': prompt.trim(),
          'imageData': base64Encode(imageBytes),
          'mimeType': mimeType,
        },
      );

      final data = response.data;
      if (response.status != null && response.status! >= 400) {
        throw Exception(data?['error'] ?? 'Analysis failed');
      }

      final text = data?['text'];
      if (text == null || text.toString().isEmpty) {
        throw Exception('Empty analysis response');
      }

      _logger.i('Analysis complete');
      return text.toString();
    } catch (e) {
      _logger.e('Error analyzing image: $e');
      rethrow;
    }
  }
}