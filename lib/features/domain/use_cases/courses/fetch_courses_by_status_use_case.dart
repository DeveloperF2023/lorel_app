import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_by_status_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchCoursesByStatusUseCase {
  final Repository repository;

  FetchCoursesByStatusUseCase({required this.repository});
  Future<Either<Failure, List<CoursesByStatusEntity>>> callback(String status) {
    return repository.getCoursesByStatus(status);
  }
}
