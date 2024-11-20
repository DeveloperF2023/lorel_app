import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/lives/lives_entity.dart';

import '../../repositories/repository.dart';

class FetchLivesUseCase {
  final Repository repository;

  FetchLivesUseCase({required this.repository});
  Future<Either<Failure, List<LivesEntity>>> callback() {
    return repository.getAllLives();
  }
}
