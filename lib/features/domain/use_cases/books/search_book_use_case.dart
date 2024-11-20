import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class SearchBooksUseCase {
  final Repository repository;

  SearchBooksUseCase({required this.repository});
  Future<Either<Failure, List<BookEntity>>> callback(String query) {
    return repository.searchBooks(query);
  }
}
