part of 'remove_from_favorite_list_cubit.dart';

sealed class RemoveFromFavoriteListState extends Equatable {
  const RemoveFromFavoriteListState();
}

final class RemoveFromFavoriteListInitial extends RemoveFromFavoriteListState {
  @override
  List<Object> get props => [];
}

final class RemoveFromFavoriteListLoading extends RemoveFromFavoriteListState {
  @override
  List<Object> get props => [];
}

final class RemoveFromFavoriteListLoaded extends RemoveFromFavoriteListState {
  @override
  List<Object> get props => [];
}

final class RemoveFromFavoriteListFailure extends RemoveFromFavoriteListState {
  final String message;

  const RemoveFromFavoriteListFailure({required this.message});
  @override
  List<Object> get props => [message];
}
