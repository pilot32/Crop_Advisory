/// Chat Message Model
/// 
/// Represents chat messages in the AI chatbot feature

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

enum MessageRole {
  user,
  assistant,
  system,
}

enum MessageStatus {
  sending,
  sent,
  failed,
}

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required String sessionId,
    required String userId,
    required MessageRole role,
    required String content,
    @Default(MessageStatus.sent) MessageStatus status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
}

@freezed
class ChatSession with _$ChatSession {
  const factory ChatSession({
    required String id,
    required String userId,
    required String title,
    required List<ChatMessageModel> messages,
    String? language,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatSession;

  factory ChatSession.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionFromJson(json);
}
