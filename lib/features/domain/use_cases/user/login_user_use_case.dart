import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../entities/user/user_entity.dart';
import '../../repositories/repository.dart';

class LoginUserUseCase {
  final Repository repository;

  LoginUserUseCase({required this.repository});
  Future<Either<Failure, UserEntity>> callback(String email, String password) {
    return repository.loginUser(email, password);
  }
}
