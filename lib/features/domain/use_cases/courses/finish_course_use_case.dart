import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FinishCourseUseCase {
  final Repository repository;

  FinishCourseUseCase({required this.repository});
  Future<Either<Failure, String>> callback(int courseId, int formationId) {
    return repository.finishCourse(courseId, formationId);
  }
}
