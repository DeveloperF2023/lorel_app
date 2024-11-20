import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchWorkshopsByIdUseCase {
  final Repository repository;

  FetchWorkshopsByIdUseCase({required this.repository});
  Future<Either<Failure, WorkshopEntity>> callback(int workshopId) {
    return repository.getWorkshopsById(workshopId);
  }
}
