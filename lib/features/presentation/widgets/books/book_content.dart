part of 'widgets_imports.dart';

class BookContent extends StatelessWidget {
  final BookEntity books;
  final void Function()? onReadPdf;
  const BookContent({super.key, this.onReadPdf, required this.books});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onReadPdf,
                child: Container(
                  height: 78.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(books.image!))),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onReadPdf,
                    child: Text(
                      books.title!,
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 20.sp,
                          color: AppColors.secondarySmokeyGrey),
                    ),
                  ),
                  Text(
                    books.author!,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 14.sp,
                        color: AppColors.secondarySmokeyGrey,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    books.domain!,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 14.sp,
                        color: AppColors.secondarySmokeyGrey,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onReadPdf,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.secondarySmokeyGrey,
              size: 20.sp,
            ),
          )
        ],
      ),
    );
  }
}
