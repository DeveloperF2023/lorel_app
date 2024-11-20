import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/payment/rib_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchRibUseCase {
  final Repository repository;

  FetchRibUseCase({required this.repository});
  Future<Either<Failure, RibEntity>> callback() {
    return repository.getRib();
  }
}
