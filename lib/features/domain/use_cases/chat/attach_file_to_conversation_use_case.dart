import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/chat/send_message_response_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class AttachFileToConversationsUseCase {
  final Repository repository;

  AttachFileToConversationsUseCase({required this.repository});
  Future<Either<Failure, SendMessageResponseEntity>> callback(
      int conversationId, File file, String type) {
    return repository.attachFile(conversationId, file, type);
  }
}
