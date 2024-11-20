import '../../repositories/repository.dart';

class GetCurrentTokenUserUseCase {
  final Repository repository;

  GetCurrentTokenUserUseCase({required this.repository});
  Future<String> callback() {
    return repository.getCurrentCustomerUser();
  }
}
