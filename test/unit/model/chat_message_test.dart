import 'package:flutter_test/flutter_test.dart';
import 'package:crop_advisory/models/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('creates message with auto-generated id', () {
      final message = ChatMessage(
        content: 'Hello',
        role: MessageRole.user,
      );
      expect(message.content, equals('Hello'));
      expect(message.role, equals(MessageRole.user));
      expect(message.id, isNotEmpty);
      expect(message.isError, isFalse);
      expect(message.timestamp, isNotNull);
    });

    test('creates message with custom id', () {
      final message = ChatMessage(
        id: 'custom-id',
        content: 'Test',
        role: MessageRole.assistant,
      );
      expect(message.id, equals('custom-id'));
    });

    test('creates error message', () {
      final message = ChatMessage(
        content: 'Error occurred',
        role: MessageRole.assistant,
        isError: true,
      );
      expect(message.isError, isTrue);
    });

    test('toJson serializes correctly', () {
      final message = ChatMessage(
        id: 'test-id',
        content: 'Hello world',
        role: MessageRole.user,
        isError: false,
      );
      final json = message.toJson();
      expect(json['id'], equals('test-id'));
      expect(json['content'], equals('Hello world'));
      expect(json['role'], equals('user'));
      expect(json['isError'], isFalse);
      expect(json['timestamp'], isNotNull);
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'id': 'test-id',
        'content': 'Hello world',
        'role': 'assistant',
        'timestamp': '2025-01-01T12:00:00.000',
        'isError': false,
      };
      final message = ChatMessage.fromJson(json);
      expect(message.id, equals('test-id'));
      expect(message.content, equals('Hello world'));
      expect(message.role, equals(MessageRole.assistant));
      expect(message.isError, isFalse);
    });

    test('fromJson defaults isError to false', () {
      final json = {
        'id': 'test-id',
        'content': 'Hello',
        'role': 'user',
        'timestamp': '2025-01-01T12:00:00.000',
      };
      final message = ChatMessage.fromJson(json);
      expect(message.isError, isFalse);
    });

    test('copyWith creates new message with updated fields', () {
      final message = ChatMessage(
        id: 'id-1',
        content: 'Original',
        role: MessageRole.user,
      );
      final updated = message.copyWith(content: 'Updated');
      expect(updated.id, equals('id-1')); // unchanged
      expect(updated.content, equals('Updated')); // changed
      expect(updated.role, equals(MessageRole.user)); // unchanged
    });

    test('MessageRole enum has user, assistant, system', () {
      expect(MessageRole.values.length, equals(3));
      expect(MessageRole.values, containsAll([
        MessageRole.user,
        MessageRole.assistant,
        MessageRole.system,
      ]));
    });
  });
}