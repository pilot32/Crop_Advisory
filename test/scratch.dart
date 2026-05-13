import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  var resp1 = GenerateContentResponse([
    Candidate(
      Content('model', [TextPart('hello')]),
      null,
      null,
      null,
      null,
    )
  ], null);
  print('resp1 text: ${resp1.text}');

  var resp2 = GenerateContentResponse([], null);
  print('resp2 text: ${resp2.text}');
}
