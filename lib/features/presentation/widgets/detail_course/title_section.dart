part of 'widgets_imports.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final int price;
  const TitleSection({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: null,
            overflow: TextOverflow.visible,
            style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        Directionality(
          textDirection: AppLocalization.of(context)!.isArabicSelected(context)
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Text(
            "$price DH",
            style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
