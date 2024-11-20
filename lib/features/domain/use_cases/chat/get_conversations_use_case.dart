import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/chat/chat_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchConversationsUseCase {
  final Repository repository;

  FetchConversationsUseCase({required this.repository});
  Future<Either<Failure, List<ChatEntity>>> callback() {
    return repository.getChat();
  }
}
