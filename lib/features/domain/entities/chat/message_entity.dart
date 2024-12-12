import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/user/user_data_entity.dart';

class MessageEntity extends Equatable {
  final int? id;
  final int? conversationId;
  final int? userId;
  final String? type;
  final String? file;
  final String? body;
  final String? createdAt;
  final String? updatedAt;
  final String? lastRead;
  final UserDataEntity? user;

  const MessageEntity(
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
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        conversationId,
        userId,
        type,
        file,
        body,
        createdAt,
        updatedAt,
        lastRead,
        user
      ];
}
