import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class StartCourseUseCase {
  final Repository repository;

  StartCourseUseCase({required this.repository});
  Future<Either<Failure, String>> callback(int courseId, int formationId) {
    return repository.startCourse(courseId, formationId);
  }
}
