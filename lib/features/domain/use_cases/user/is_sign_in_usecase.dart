import '../../repositories/repository.dart';

class IsSignInUserUseCase {
  final Repository repository;

  IsSignInUserUseCase({required this.repository});
  Future<bool> callback() {
    return repository.isSignInUser();
  }
}
