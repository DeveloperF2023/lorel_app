import 'package:school_test_online/features/domain/entities/chat/last_message_entity.dart';

import '../user/user_data_model.dart';

class LastMessageModel extends LastMessageEntity {
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

  LastMessageModel(
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

  LastMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    type = json['type'];
    file = json['file'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastRead = json['last_read'];
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;
  }
}
