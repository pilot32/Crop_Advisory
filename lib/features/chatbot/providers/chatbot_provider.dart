import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/chat_message.dart';
import '../../../services/gemini_service.dart';
import '../../../main.dart';
import 'dart:convert';

final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  final geminiService = GeminiService(); // no dependency injection needed now
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
            '- Crop recommendations\n'
            '- Pest and disease management\n'
            '- Fertilizer advice\n'
            '- Weather-based farming decisions\n'
            '- And more!\n\n'
            'Note: You have 5 AI questions per day.',
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
      final userMessage = ChatMessage(content: content, role: MessageRole.user);
      state = [...state, userMessage];

      logger.i('User message added');

      // Build history from last 6 messages for context
      final history = state
          .where((m) => m.role != MessageRole.system)
          .toList()
          .reversed
          .take(6)
          .map((m) => {'role': m.role.name, 'content': m.content})
          .toList();

      // Call edge function via GeminiService
      final response = await _geminiService.sendChatMessage(
        session: '',
        message: content,
        history: history,
      );

      final assistantMessage = ChatMessage(
        content: response,
        role: MessageRole.assistant,
      );
      state = [...state, assistantMessage];

      logger.i('Assistant response added');
    } on RateLimitException catch (e) {
      final errorMessage = ChatMessage(
        content: 'Daily limit reached (${e.remaining}/5 remaining). Try again tomorrow!',
        role: MessageRole.assistant,
        isError: true,
      );
      state = [...state, errorMessage];
    } catch (e) {
      logger.e('Error sending message: $e');
      final errorMessage = ChatMessage(
        content: 'Sorry, I encountered an error. Please check your internet connection and try again.',
        role: MessageRole.assistant,
        isError: true,
      );
      state = [...state, errorMessage];
    } finally {
      _isProcessing = false;
    }
  }

  void clearChat() {
    state = [];
    _addWelcomeMessage();
    logger.i('Chat cleared');
  }

  void removeMessage(String messageId) {
    state = state.where((msg) => msg.id != messageId).toList();
  }
}

final isChatProcessingProvider = Provider<bool>((ref) {
  final chatNotifier = ref.read(chatMessagesProvider.notifier);
  return chatNotifier.isProcessing;
});