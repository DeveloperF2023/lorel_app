import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchWorkshopsUseCase {
  final Repository repository;

  FetchWorkshopsUseCase({required this.repository});
  Future<Either<Failure, List<WorkshopEntity>>> callback() async {
    return repository.getWorkshops();
  }
}
