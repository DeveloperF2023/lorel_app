import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/user/request_register_user_entity.dart';

import '../../../../core/error/failure.dart';
import '../../entities/user/user_entity.dart';
import '../../repositories/repository.dart';

class RegisterUserUseCase {
  final Repository repository;

  RegisterUserUseCase({required this.repository});
  Future<Either<Failure, UserEntity>> callback(
      RequestRegisterUserEntity requests) {
    return repository.registerUser(requests);
  }
}
