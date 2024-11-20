import 'package:school_test_online/features/domain/entities/chat/chat_entity.dart';

import 'group_model.dart';
import 'last_message_model.dart';

class ChatModel extends ChatEntity {
  int? id;
  int? groupId;
  String? createdAt;
  String? updatedAt;
  int? lastMessageId;
  LastMessageModel? lastMessage;
  GroupModel? group;

  ChatModel(
      {this.id,
      this.groupId,
      this.createdAt,
      this.updatedAt,
      this.lastMessageId,
      this.lastMessage,
      this.group});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastMessageId = json['last_message_id'];
    lastMessage = json['last_message'] != null
        ? LastMessageModel.fromJson(json['last_message'])
        : null;
    group =
        json['group'] != null ? new GroupModel.fromJson(json['group']) : null;
  }

  static List<ChatModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ChatModel.fromJson(json)).toList();
  }
}
