import 'package:equatable/equatable.dart';

class SendMessageResponseEntity extends Equatable {
  final int? userId;
  final String? body;
  final int? conversationId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? lastRead;

  const SendMessageResponseEntity(
      {this.userId,
      this.body,
      this.conversationId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.lastRead});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [userId, body, conversationId, updatedAt, createdAt, id, lastRead];
}
