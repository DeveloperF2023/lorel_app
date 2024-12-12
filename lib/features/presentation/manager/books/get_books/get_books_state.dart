part of 'get_books_cubit.dart';

sealed class GetBooksState extends Equatable {
  const GetBooksState();
}

final class GetBooksInitial extends GetBooksState {
  @override
  List<Object> get props => [];
}

final class GetBooksLoading extends GetBooksState {
  @override
  List<Object> get props => [];
}

final class GetBooksLoaded extends GetBooksState {
  final List<BookEntity> books;

  const GetBooksLoaded({required this.books});
  @override
  List<Object> get props => [books];
}

final class GetBooksFailure extends GetBooksState {
  final String message;

  const GetBooksFailure({required this.message});
  @override
  List<Object> get props => [message];
}
