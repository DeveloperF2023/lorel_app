import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';
import 'package:school_test_online/features/domain/use_cases/books/fetch_books_use_case.dart';

part 'get_books_state.dart';

class GetBooksCubit extends Cubit<GetBooksState> {
  final FetchBooksUseCase fetchBooksUseCase;
  GetBooksCubit({required this.fetchBooksUseCase}) : super(GetBooksInitial());

  Future<void> fetchBooks() async {
    emit(GetBooksLoading());
    try {
      final result = await fetchBooksUseCase.callback();
      result.fold((l) => emit(GetBooksFailure(message: l.message)),
          (r) => emit(GetBooksLoaded(books: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetBooksFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetBooksFailure(message: e.toString()));
    }
  }
}
