import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/user/update_user_entity.dart';

import '../../repositories/repository.dart';

class UpdateProfileUserUseCase {
  final Repository repository;

  UpdateProfileUserUseCase({required this.repository});
  Future<Either<Failure, UpdateUserEntity>> callback(
      String lastName, String address, String phone, String country) {
    return repository.updateProfile(lastName, address, phone, country);
  }
}
