import '../../repositories/repository.dart';

class DeleteFromFavoriteListUseCase {
  final Repository repository;

  DeleteFromFavoriteListUseCase({required this.repository});
  Future<String> callback(int offerId) {
    return repository.deleteFromFavoriteList(offerId);
  }
}
