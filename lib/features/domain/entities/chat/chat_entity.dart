import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/group_entity.dart';
import 'package:school_test_online/features/domain/entities/chat/last_message_entity.dart';

class ChatEntity extends Equatable {
  final int? id;
  final int? groupId;
  final String? createdAt;
  final String? updatedAt;
  final int? lastMessageId;
  final LastMessageEntity? lastMessage;
  final GroupEntity? group;

  const ChatEntity(
      {this.id,
      this.groupId,
      this.createdAt,
      this.updatedAt,
      this.lastMessageId,
      this.lastMessage,
      this.group});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, groupId, createdAt, updatedAt, lastMessageId, lastMessage, group];
}
