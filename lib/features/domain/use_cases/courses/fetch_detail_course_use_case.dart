import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchDetailCourseUseCase {
  final Repository repository;

  FetchDetailCourseUseCase({required this.repository});
  Future<Either<Failure, DetailCourseEntity>> callback(
      int courseId, int formationId) {
    return repository.getDetailCourse(courseId, formationId);
  }
}
