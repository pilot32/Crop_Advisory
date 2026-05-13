import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crop_advisory/services/gemini_pest_service.dart';

// ✅ Mocking our abstract wrapper, not the final GenerativeModel
class MockGenerativeModelWrapper extends Mock implements GenerativeModelWrapper {}

GenerateContentResponse _fakeResponse(String? text) {
  if (text == null) {
    return GenerateContentResponse([], null);
  }
  return GenerateContentResponse([
    Candidate(
      Content('model', [TextPart(text)]),
      null,
      null,
      null,
      null,
    )
  ], null);
}

void main() {
  late GeminiPestService service;
  late MockGenerativeModelWrapper mockWrapper;

  setUpAll(() {
    registerFallbackValue(<Content>[]);
  });

  setUp(() {
    mockWrapper = MockGenerativeModelWrapper();
    service = GeminiPestService(mockWrapper);
  });

  group('analyzeImage', () {
    // PNG magic bytes
    final testImageBytes = [0x89, 0x50, 0x4E, 0x47];

    test('returns analysis text on success', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse(
          'The plant shows signs of leaf blight with moderate severity.',
        ),
      );

      final result = await service.analyzeImage(
        imageBytes: testImageBytes,
        mimeType: 'image/png',
      );

      expect(result, isNotEmpty);
      expect(result, contains('leaf blight'));
      verify(() => mockWrapper.generateContent(any())).called(1);
    });

    test('default language is english', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse('Some analysis.'),
      );

      await service.analyzeImage(
        imageBytes: testImageBytes,
        mimeType: 'image/png',
      );

      final captured =
          verify(() => mockWrapper.generateContent(captureAny())).captured;
      final contents = captured.first as List<Content>;
      final textPart = contents.first.parts.whereType<TextPart>().first;

      expect(textPart.text, contains('english'));
    });

    test('includes correct language in prompt', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse('Analysis in Hindi.'),
      );

      await service.analyzeImage(
        imageBytes: testImageBytes,
        mimeType: 'image/jpeg',
        language: 'hindi',
      );

      final captured =
          verify(() => mockWrapper.generateContent(captureAny())).captured;
      final contents = captured.first as List<Content>;
      final textPart = contents.first.parts.whereType<TextPart>().first;

      // Matches the exact prompt template in the service
      expect(textPart.text, contains('hindi'));
      expect(textPart.text, contains('Indian agriculture'));
    });

    test('sends image bytes and mimeType as DataPart', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse('Analysis.'),
      );

      await service.analyzeImage(
        imageBytes: testImageBytes,
        mimeType: 'image/png',
      );

      final captured =
          verify(() => mockWrapper.generateContent(captureAny())).captured;
      final contents = captured.first as List<Content>;
      final dataPart = contents.first.parts.whereType<DataPart>().first;

      expect(dataPart.mimeType, equals('image/png'));
      expect(dataPart.bytes, equals(Uint8List.fromList(testImageBytes)));
    });

    test('throws Exception when response text is null', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse(null),
      );

      await expectLater(
        () => service.analyzeImage(
          imageBytes: testImageBytes,
          mimeType: 'image/jpeg',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Empty analysis response'),
          ),
        ),
      );
    });

    test('throws Exception when response text is empty string', () async {
      when(() => mockWrapper.generateContent(any())).thenAnswer(
        (_) async => _fakeResponse(''),
      );

      await expectLater(
        () => service.analyzeImage(
          imageBytes: testImageBytes,
          mimeType: 'image/jpeg',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Empty analysis response'),
          ),
        ),
      );
    });

    test('rethrows on API error', () async {
      when(() => mockWrapper.generateContent(any()))
          .thenThrow(Exception('API_KEY_INVALID'));

      await expectLater(
        () => service.analyzeImage(
          imageBytes: testImageBytes,
          mimeType: 'image/jpeg',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('API_KEY_INVALID'),
          ),
        ),
      );
    });
  });
}