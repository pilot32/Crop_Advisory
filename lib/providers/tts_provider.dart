import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tts_service.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();

  // Wire service callbacks to Riverpod state so UI updates when speaking state changes
  service.onSpeakingStateChanged = (isSpeaking) {
    // update whether TTS is speaking
    ref.read(isTtsSpeakingProvider.notifier).state = isSpeaking;

    // when speaking stops, clear the current message id so UI removes highlight
    if (!isSpeaking) {
      ref.read(currentTtsMessageProvider.notifier).state = null;
    }
  };

  ref.onDispose(() => service.dispose());
  return service;
});

/// Whether TTS is currently speaking
final isTtsSpeakingProvider = StateProvider<bool>((ref) {
  return false;
});

/// Currently speaking message ID (for highlighting the active bubble)
final currentTtsMessageProvider = StateProvider<String?>((ref) {
  return null;
});

/// Whether auto-read is enabled for new AI messages
final autoReadEnabledProvider = StateProvider<bool>((ref) {
  return false;
});