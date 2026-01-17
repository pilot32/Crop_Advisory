// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageModelImpl _$$ChatMessageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageModelImpl(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      role: $enumDecode(_$MessageRoleEnumMap, json['role']),
      content: json['content'] as String,
      status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
          MessageStatus.sent,
      imageUrl: json['imageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatMessageModelImplToJson(
        _$ChatMessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'role': _$MessageRoleEnumMap[instance.role]!,
      'content': instance.content,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'imageUrl': instance.imageUrl,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$MessageRoleEnumMap = {
  MessageRole.user: 'user',
  MessageRole.assistant: 'assistant',
  MessageRole.system: 'system',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.failed: 'failed',
};

_$ChatSessionImpl _$$ChatSessionImplFromJson(Map<String, dynamic> json) =>
    _$ChatSessionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChatSessionImplToJson(_$ChatSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'messages': instance.messages,
      'language': instance.language,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
