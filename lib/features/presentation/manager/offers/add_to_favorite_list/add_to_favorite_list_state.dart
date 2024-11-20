part of 'add_to_favorite_list_cubit.dart';

sealed class AddToFavoriteListState extends Equatable {
  const AddToFavoriteListState();
}

final class AddToFavoriteListInitial extends AddToFavoriteListState {
  @override
  List<Object> get props => [];
}

final class AddToFavoriteListLoading extends AddToFavoriteListState {
  @override
  List<Object> get props => [];
}

final class AddToFavoriteListLoaded extends AddToFavoriteListState {
  @override
  List<Object> get props => [];
}

final class AddToFavoriteListFailure extends AddToFavoriteListState {
  final String message;

  AddToFavoriteListFailure({required this.message});
  @override
  List<Object> get props => [message];
}
