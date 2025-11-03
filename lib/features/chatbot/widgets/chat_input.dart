/// Chat Input Widget
/// 
/// Text input field for sending messages in the chat

import 'package:flutter/material.dart';
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
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty && !widget.isProcessing) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
      setState(() => _hasText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !widget.isProcessing,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Ask me anything about farming...',
                  hintStyle: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                    borderSide: BorderSide.none,
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
                    : AppColors.textSecondary.withOpacity(0.3),
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
