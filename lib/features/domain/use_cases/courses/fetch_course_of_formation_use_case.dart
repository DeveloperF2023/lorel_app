import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchCoursesOfFormationUseCase {
  final Repository repository;

  FetchCoursesOfFormationUseCase({required this.repository});
  Future<Either<Failure, List<DetailCourseEntity>>> callback(int formationId) {
    return repository.getCoursesOfFormation(formationId);
  }
}
