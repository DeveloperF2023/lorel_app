import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class ApplyToOfferUseCase {
  final Repository repository;

  ApplyToOfferUseCase({required this.repository});
  Future<Either<Failure, String>> callback(int offerId, File resume) {
    return repository.applyOffer(offerId, resume);
  }
}
