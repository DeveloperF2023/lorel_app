import '../../repositories/repository.dart';

class UpdatePasswordUserUseCase {
  final Repository repository;

  UpdatePasswordUserUseCase({required this.repository});
  Future<String> callback(
      String oldPassword, String password, String confirmationPassword) {
    return repository.updatePassword(
        oldPassword, password, confirmationPassword);
  }
}
