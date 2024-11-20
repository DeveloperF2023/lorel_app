import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchDetailFormationUseCase {
  final Repository repository;

  FetchDetailFormationUseCase({required this.repository});
  Future<Either<Failure, CoursesEntity>> callback(
      int domainId, int formationId) {
    return repository.getDetailOfFormation(domainId, formationId);
  }
}
