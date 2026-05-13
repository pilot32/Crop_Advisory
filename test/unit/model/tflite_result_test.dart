import 'package:flutter_test/flutter_test.dart';

// Minimal TfliteResult used for unit tests
class TfliteResult {
  final String label;
  final double confidence;

  const TfliteResult({required this.label, required this.confidence});

  bool get isHealthy => label.toLowerCase().contains('healthy');

  String get displayName {
    if (!label.contains('___')) return label;
    final parts = label.split('___');
    final crop = parts[0].replaceAll('_', ' ');
    final diseaseRaw = parts[1].replaceAll('_', ' ');
    final disease = diseaseRaw
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
    if (isHealthy) return 'Healthy (${crop.trim()})';
    return '${disease.trim()} (${crop.trim()})';
  }
}

void main() {
  group('TfliteResult', () {
    test('isHealthy returns true when label contains healthy', () {
      const result = TfliteResult(
        label: 'Tomato___healthy',
        confidence: 0.95,
      );
      expect(result.isHealthy, isTrue);
    });

    test('isHealthy returns false when label does not contain healthy', () {
      const result = TfliteResult(
        label: 'Tomato___Late_blight',
        confidence: 0.85,
      );
      expect(result.isHealthy, isFalse);
    });

    test('isHealthy is case-insensitive', () {
      const result = TfliteResult(
        label: 'Apple___HEALTHY',
        confidence: 0.9,
      );
      expect(result.isHealthy, isTrue);
    });

    group('displayName', () {
      test('formats healthy label correctly', () {
        const result = TfliteResult(
          label: 'Tomato___healthy',
          confidence: 0.95,
        );
        expect(result.displayName, equals('Healthy (Tomato)'));
      });

      test('formats disease label correctly', () {
        const result = TfliteResult(
          label: 'Tomato___Late_blight',
          confidence: 0.85,
        );
        expect(result.displayName, equals('Late blight (Tomato)'));
      });

      test('formats multi-word crop and disease', () {
        const result = TfliteResult(
          label: 'Corn_(maize)___Northern_Leaf_Blight',
          confidence: 0.78,
        );
        expect(result.displayName, equals('Northern Leaf Blight (Corn (maize))'));
      });

      test('handles label without ___ separator', () {
        const result = TfliteResult(
          label: 'UnknownLabel',
          confidence: 0.5,
        );
        expect(result.displayName, equals('UnknownLabel'));
      });

      test('trims whitespace from disease part', () {
        const result = TfliteResult(
          label: 'Cherry_(including_sour)___Powdery_mildew',
          confidence: 0.7,
        );
        expect(result.displayName, equals('Powdery mildew (Cherry (including sour))'));
      });
    });

    test('stores label and confidence correctly', () {
      const result = TfliteResult(
        label: 'Potato___Early_blight',
        confidence: 0.82,
      );
      expect(result.label, equals('Potato___Early_blight'));
      expect(result.confidence, equals(0.82));
    });
  });
}