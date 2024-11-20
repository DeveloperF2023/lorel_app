import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/offers/favorite_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchFavoritesByTypeUseCase {
  final Repository repository;

  FetchFavoritesByTypeUseCase({required this.repository});
  Future<Either<Failure, List<FavoriteEntity>>> callback() {
    return repository.getAllFavorite();
  }
}
