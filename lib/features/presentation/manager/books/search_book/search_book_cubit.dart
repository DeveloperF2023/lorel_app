import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';
import 'package:school_test_online/features/domain/use_cases/books/search_book_use_case.dart';

part 'search_book_state.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  final SearchBooksUseCase searchBooksUseCase;
  SearchBookCubit({required this.searchBooksUseCase})
      : super(SearchBookInitial());
  Future<void> searchBooks({required String query}) async {
    emit(SearchBookLoading());
    try {
      final result = await searchBooksUseCase.callback(query);
      result.fold((l) => emit(SearchBookFailure(message: l.message)),
          (r) => emit(SearchBookLoaded(book: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(SearchBookFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(SearchBookFailure(message: e.toString()));
    }
  }
}
