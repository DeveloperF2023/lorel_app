import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/features/domain/entities/book/book_entity.dart';
import 'package:school_test_online/features/presentation/widgets/books/widgets_imports.dart';

import '../../../../dependencies_injection.dart';
import '../../manager/books/get_books/get_books_cubit.dart';
import '../../widgets/books/search_book.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BookEntity> _books = [];
  List<BookEntity> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    locator<GetBooksCubit>().fetchBooks();
  }

  void _filterBooks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredBooks = _books;
      });
    } else {
      final filtered = _books.where((book) {
        return book.title!.toLowerCase().contains(query.toLowerCase()) ||
            book.author!.toLowerCase().contains(query.toLowerCase()) ||
            book.domain!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _filteredBooks = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<GetBooksCubit>()..fetchBooks(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryGeyser,
        resizeToAvoidBottomInset: false,
        appBar: const AppBarBooks(),
        body: SafeArea(
            child: Column(
          children: [
            SearchBook(
              searchController: _searchController,
              onChanged: _filterBooks,
            ),
            // BlocBuilder for handling book state
            BlocBuilder<GetBooksCubit, GetBooksState>(
              builder: (context, state) {
                if (state is GetBooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetBooksLoaded) {
                  _books = state.books;
                  if (_filteredBooks.isEmpty) _filteredBooks = _books;

                  return Expanded(
                    child: BookList(filteredBooks: _filteredBooks),
                  );
                } else if (state is GetBooksFailure) {
                  return Center(child: Text(state.message));
                }
                return Container(); // Placeholder for unhandled states
              },
            ),
          ],
        )),
      ),
    );
  }
}
