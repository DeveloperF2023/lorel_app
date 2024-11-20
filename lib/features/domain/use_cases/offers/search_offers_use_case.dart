import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../entities/offers/offers_entity.dart';
import '../../repositories/repository.dart';

class SearchOffersUseCase {
  final Repository repository;

  SearchOffersUseCase({required this.repository});
  Future<Either<Failure, List<OffersEntity>>> callback(String query) {
    return repository.searchOffers(query);
  }
}
