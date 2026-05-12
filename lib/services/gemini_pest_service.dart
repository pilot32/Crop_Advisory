import 'dart:typed_data';

//import 'package:crop_advisory/main.dart';
//import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class GeminiPestService {
  final Logger _logger = Logger();

  final GenerativeModel _visionModel;
  GeminiPestService(this._visionModel);
  //
  Future<String> analyzeImage({
    required List<int> imageBytes,
    required String mimeType,
    String language = 'english',
  }) async {
    try {
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

      final content = Content.multi([
        TextPart(prompt),
        DataPart(mimeType, Uint8List.fromList(imageBytes)),
      ]);

      final response = await _visionModel.generateContent([content]);
      final text = response.text;
      if (text == null || text.isEmpty) {
        throw Exception('Empty analysis response');
      }
      _logger.i('Analysis done');
      return text;
    } catch (e) {
      _logger.e('Error analyzing image: $e');
      rethrow;
    }
  }
}
