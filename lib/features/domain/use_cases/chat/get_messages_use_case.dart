import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/chat/message_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchMessagesUseCase {
  final Repository repository;

  FetchMessagesUseCase({required this.repository});
  Future<Either<Failure, List<MessageEntity>>> callback(int conversationId) {
    return repository.getMessages(conversationId);
  }
}
