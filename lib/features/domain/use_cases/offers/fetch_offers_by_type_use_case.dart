import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/offers/offers_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchOffersByTypeUseCase {
  final Repository repository;

  FetchOffersByTypeUseCase({required this.repository});
  Future<Either<Failure, List<OffersEntity>>> callback(String type) {
    return repository.getOffersByType(type);
  }
}
