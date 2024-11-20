import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../entities/offers/detail_offer_entity.dart';
import '../../repositories/repository.dart';

class FetchDetailOffersUseCase {
  final Repository repository;

  FetchDetailOffersUseCase({required this.repository});
  Future<Either<Failure, DetailOfferEntity>> callback(int offerId) {
    return repository.getDetailOffer(offerId);
  }
}
