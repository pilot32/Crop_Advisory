/// Message Bubble Widget
///
/// Displays a single chat message with appropriate styling
/// Includes "Read Aloud" button for AI assistant messages

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/chat_message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../providers/tts_provider.dart';

class MessageBubble extends ConsumerWidget {
  final ChatMessage message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUser = message.role == MessageRole.user;
    final isAssistant = message.role == MessageRole.assistant && !message.isError;
    final timeFormat = DateFormat('HH:mm');
    final tts = ref.watch(ttsServiceProvider);
    final isSpeakingThis = ref.watch(currentTtsMessageProvider) == message.id;

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
                border: isSpeakingThis
                    ? Border.all(color: AppColors.primary, width: 1.5)
                    : null,
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
                  if (isAssistant)
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
                  if (isAssistant)
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Read aloud button for AI messages
                if (isAssistant) ...[
                  InkWell(
                    onTap: () async {
                      if (isSpeakingThis) {
                        await tts.stop();
                        ref.read(currentTtsMessageProvider.notifier).state = null;
                      } else {
                        ref.read(currentTtsMessageProvider.notifier).state = message.id;
                        await tts.speak(
                          text: message.content,
                          messageId: message.id,
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSpeakingThis
                                ? Icons.stop_circle_outlined
                                : Icons.volume_up_outlined,
                            size: 14,
                            color: isSpeakingThis
                                ? AppColors.error
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            isSpeakingThis ? 'Stop' : 'Read',
                            style: AppTextStyles.caption.copyWith(
                              color: isSpeakingThis
                                  ? AppColors.error
                                  : AppColors.primary,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingSM),
                ],
                Text(
                  timeFormat.format(message.timestamp),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}