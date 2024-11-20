import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/chat/send_message_response_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class SendMessagesUseCase {
  final Repository repository;

  SendMessagesUseCase({required this.repository});
  Future<Either<Failure, SendMessageResponseEntity>> callback(
      int conversationId, String content) {
    return repository.sendMessage(conversationId, content);
  }
}
