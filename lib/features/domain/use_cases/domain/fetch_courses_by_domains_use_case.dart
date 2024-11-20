import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchCoursesByDomainUseCase {
  final Repository repository;

  FetchCoursesByDomainUseCase({required this.repository});
  Future<Either<Failure, List<CoursesEntity>>> callback(int domainId) {
    return repository.getCoursesByDomain(domainId);
  }
}
