/// Message Bubble Widget
/// 
/// Displays a single chat message with appropriate styling

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/chat_message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    final timeFormat = DateFormat('HH:mm');

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingSM,
          horizontal: AppDimensions.paddingMD,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.primary
                    : message.isError
                        ? AppColors.error.withOpacity(0.1)
                        : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppDimensions.radiusLG),
                  topRight: const Radius.circular(AppDimensions.radiusLG),
                  bottomLeft: Radius.circular(
                    isUser ? AppDimensions.radiusLG : AppDimensions.radiusSM,
                  ),
                  bottomRight: Radius.circular(
                    isUser ? AppDimensions.radiusSM : AppDimensions.radiusLG,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser && !message.isError)
                    Row(
                      children: [
                        Icon(
                          Icons.smart_toy,
                          size: AppDimensions.iconSM,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppDimensions.paddingSM),
                        Text(
                          'AI Assistant',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  if (!isUser && !message.isError)
                    const SizedBox(height: AppDimensions.paddingSM),
                  Text(
                    message.content,
                    style: AppTextStyles.body.copyWith(
                      color: isUser
                          ? AppColors.textLight
                          : message.isError
                              ? AppColors.error
                              : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              timeFormat.format(message.timestamp),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
