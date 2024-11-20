import 'package:school_test_online/features/domain/entities/chat/message_entity.dart';

import '../user/user_data_model.dart';

class MessagesModel extends MessageEntity {
  int? id;
  int? conversationId;
  int? userId;
  String? type;
  String? file;
  String? body;
  String? createdAt;
  String? updatedAt;
  String? lastRead;
  UserDataModel? user;

  MessagesModel(
      {this.id,
      this.conversationId,
      this.userId,
      this.type,
      this.file,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.lastRead,
      this.user});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    type = json['type'];
    file = json['file'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastRead = json['last_read'];
    user =
        json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
  }

  static List<MessagesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MessagesModel.fromJson(json)).toList();
  }
}
