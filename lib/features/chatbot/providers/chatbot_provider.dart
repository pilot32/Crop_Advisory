/// Chatbot Provider
/// 
/// Manages chat state and interactions with Gemini AI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/chat_message.dart';
import '../../../services/gemini_service.dart';
import '../../../main.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return ChatNotifier(geminiService);
});

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final GeminiService _geminiService;
  bool _isProcessing = false;

  ChatNotifier(this._geminiService) : super([]) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    state = [
      ChatMessage(
        content: 'Hello! I\'m your AI farming assistant. How can I help you today?\n\n'
            'You can ask me about:\n'
            '• Crop recommendations\n'
            '• Pest and disease management\n'
            '• Fertilizer advice\n'
            '• Weather-based farming decisions\n'
            '• And more!',
        role: MessageRole.assistant,
      ),
    ];
  }

  bool get isProcessing => _isProcessing;

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty || _isProcessing) return;

    try {
      _isProcessing = true;

      // Add user message
      final userMessage = ChatMessage(
        content: content,
        role: MessageRole.user,
      );
      state = [...state, userMessage];

      logger.i('User message added to chat');

      // Get AI response
      final response = await _geminiService.sendMessage(content);

      // Add assistant message
      final assistantMessage = ChatMessage(
        content: response,
        role: MessageRole.assistant,
      );
      state = [...state, assistantMessage];

      logger.i('Assistant response added to chat');
    } catch (e) {
      logger.e('Error sending message: $e');
      
      // Add error message
      final errorMessage = ChatMessage(
        content: 'Sorry, I encountered an error. Please try again.',
        role: MessageRole.assistant,
        isError: true,
      );
      state = [...state, errorMessage];
    } finally {
      _isProcessing = false;
    }
  }

  void clearChat() {
    _geminiService.clearHistory();
    _addWelcomeMessage();
    logger.i('Chat cleared');
  }

  void removeMessage(String messageId) {
    state = state.where((msg) => msg.id != messageId).toList();
  }
}

// Provider to check if chat is processing
final isChatProcessingProvider = Provider<bool>((ref) {
  final chatNotifier = ref.read(chatMessagesProvider.notifier);
  return chatNotifier.isProcessing;
});
