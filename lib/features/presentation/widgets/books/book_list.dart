part of 'widgets_imports.dart';

class BookList extends StatelessWidget {
  final List<BookEntity> filteredBooks;

  const BookList({super.key, required this.filteredBooks});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: HelperFunctions.screenHeight(context) * .68.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final book = filteredBooks[index];
          return BookContent(
            books: book,
            onReadPdf: () => Navigator.pushNamed(
              context,
              NavigationStrings.readPdf,
              arguments: {
                "title": book.title,
                "pdfUrl": book.pdf,
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: AppColors.secondarySmokeyGrey.withValues(alpha: 0.2),
          thickness: 2,
        ),
        itemCount: filteredBooks.length,
      ),
    );
  }
}
