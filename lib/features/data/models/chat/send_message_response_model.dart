import 'package:school_test_online/features/domain/entities/chat/send_message_response_entity.dart';

class SendMessageResponseModel extends SendMessageResponseEntity {
  int? userId;
  String? body;
  int? conversationId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? lastRead;

  SendMessageResponseModel(
      {this.userId,
      this.body,
      this.conversationId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.lastRead});

  SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    body = json['body'];
    conversationId = json['conversation_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    lastRead = json['last_read'];
  }
  static List<SendMessageResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => SendMessageResponseModel.fromJson(json))
        .toList();
  }
}
