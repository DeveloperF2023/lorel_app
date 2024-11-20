import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class FetchBooksUseCase {
  final Repository repository;

  FetchBooksUseCase({required this.repository});
  Future<Either<Failure, List<BookEntity>>> callback() {
    return repository.getBooks();
  }
}
