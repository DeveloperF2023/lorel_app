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

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    //print('Raw API Response: $json');
    //     final messageData = json['message'] ?? {};
    //     print('Message Data: $messageData');
    //     final userData = messageData['user'] != null
    //         ? UserDataModel.fromJson(messageData['user'])
    //         : null;
    //     if (userData != null) {
    //       print('User Data: ${userData.toJson()}');
    //     } else {
    //       print('User data is null');
    //     }
    return MessagesModel(
      id: json['id'] ?? 0,
      conversationId: json['conversation_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? "text",
      file: json['file'] ?? "",
      body: json['body'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      lastRead: json['last_read'] ?? "",
      user: json['user'] != null ? UserDataModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'user_id': userId,
      'type': type,
      'file': file,
      'body': body,
      "created_at": createdAt,
      'updated_at': updatedAt,
      'last_read': lastRead,
      'user': user
    };
  }

  static List<MessagesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MessagesModel.fromJson(json)).toList();
  }
}
