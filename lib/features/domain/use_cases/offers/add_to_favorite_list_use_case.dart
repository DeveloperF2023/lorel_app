import '../../repositories/repository.dart';

class AddToFavoriteListUseCase {
  final Repository repository;

  AddToFavoriteListUseCase({required this.repository});
  Future<String> callback(int offerId) {
    return repository.addToFavoriteList(offerId);
  }
}
