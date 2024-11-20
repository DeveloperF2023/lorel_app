import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/timetable/schedule_entity.dart';

import '../../repositories/repository.dart';

class FetchScheduleUseCase {
  final Repository repository;

  FetchScheduleUseCase({required this.repository});
  Future<Either<Failure, Map<String, List<ScheduleEntity>>>> callback(
      String weekKey) {
    return repository.getSchedule(weekKey);
  }
}
