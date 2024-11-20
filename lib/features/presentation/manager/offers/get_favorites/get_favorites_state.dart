part of 'get_favorites_cubit.dart';

sealed class GetFavoritesState extends Equatable {
  const GetFavoritesState();
}

final class GetFavoritesInitial extends GetFavoritesState {
  @override
  List<Object> get props => [];
}

final class GetFavoritesLoading extends GetFavoritesState {
  @override
  List<Object> get props => [];
}

final class GetFavoritesLoaded extends GetFavoritesState {
  final List<FavoriteEntity> favorites;

  GetFavoritesLoaded({required this.favorites});
  @override
  List<Object> get props => [favorites];
}

final class GetFavoritesFailure extends GetFavoritesState {
  final String message;

  GetFavoritesFailure({required this.message});
  @override
  List<Object> get props => [message];
}
