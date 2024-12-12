part of 'search_book_cubit.dart';

sealed class SearchBookState extends Equatable {
  const SearchBookState();
}

final class SearchBookInitial extends SearchBookState {
  @override
  List<Object> get props => [];
}

final class SearchBookLoading extends SearchBookState {
  @override
  List<Object> get props => [];
}

final class SearchBookLoaded extends SearchBookState {
  final List<BookEntity> book;

  const SearchBookLoaded({required this.book});
  @override
  List<Object> get props => [book];
}

final class SearchBookFailure extends SearchBookState {
  final String message;

  const SearchBookFailure({required this.message});
  @override
  List<Object> get props => [message];
}
