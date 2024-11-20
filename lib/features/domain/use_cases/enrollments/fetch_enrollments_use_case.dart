import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/enrollment/enrollment_entity.dart';

import '../../repositories/repository.dart';

class FetchEnrollmentUseCase {
  final Repository repository;

  FetchEnrollmentUseCase({required this.repository});
  Future<Either<Failure, List<EnrollmentEntity>>> callback() {
    return repository.getEnrollments();
  }
}
