import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../entities/domain/domain_entity.dart';
import '../../repositories/repository.dart';

class FetchDomainsUseCase {
  final Repository repository;

  FetchDomainsUseCase({required this.repository});
  Future<Either<Failure, List<DomainEntity>>> callback() {
    return repository.getDomains();
  }
}
