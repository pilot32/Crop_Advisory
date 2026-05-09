/// Chat Input Widget
/// 
/// Text input field for sending messages in the chat

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final bool isProcessing;

  const ChatInput({
    super.key,
    required this.onSendMessage,
    this.isProcessing = false,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _hasText = false;
  bool _isListening = false;
  bool _speechAvailable = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) {
        setState(() => _isListening = false);
      },
    );
    setState(() => _speechAvailable = available);
  }

  @override
  void dispose() {
    _controller.dispose();
    _speech.cancel();
    super.dispose();
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty && !widget.isProcessing) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
      setState(() => _hasText = false);
    }
  }

  Future<void> _toggleListening() async {
    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
            _hasText = result.recognizedWords.isNotEmpty;
          });
        },
        localeId: 'en_IN', // English (India)
        listenOptions: stt.SpeechListenOptions(
          listenMode: stt.ListenMode.confirmation,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Voice input button
            Container(
              decoration: BoxDecoration(
                color: _isListening
                    ? AppColors.error.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? AppColors.error : AppColors.primary,
                ),
                onPressed: !widget.isProcessing ? _toggleListening : null,
              ),
            )
                .animate(
                  target: _isListening ? 1 : 0,
                )
                .scale(duration: 300.ms)
                .then()
                .shimmer(
                  duration: 1500.ms,
                  color: AppColors.error.withValues(alpha: 0.5),
                ),
            const SizedBox(width: AppDimensions.paddingSM),
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !widget.isProcessing && !_isListening,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  hintText: _isListening
                      ? 'Listening...'
                      : 'Ask me anything about farming...',
                  hintStyle: AppTextStyles.body.copyWith(
                    color: _isListening
                        ? AppColors.error
                        : AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark ? const Color(0xFF1E1E1E) : AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                    borderSide: _isListening
                        ? BorderSide(color: AppColors.error, width: 2)
                        : BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMD,
                    vertical: AppDimensions.paddingMD,
                  ),
                ),
                onChanged: (value) {
                  setState(() => _hasText = value.trim().isNotEmpty);
                },
                onSubmitted: (_) => _handleSend(),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSM),
            Container(
              decoration: BoxDecoration(
                color: (_hasText && !widget.isProcessing)
                    ? AppColors.primary
                    : AppColors.textSecondary.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: widget.isProcessing
                    ? SizedBox(
                        width: AppDimensions.iconMD,
                        height: AppDimensions.iconMD,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textLight,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.send,
                        color: AppColors.textLight,
                      ),
                onPressed: _hasText && !widget.isProcessing ? _handleSend : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
