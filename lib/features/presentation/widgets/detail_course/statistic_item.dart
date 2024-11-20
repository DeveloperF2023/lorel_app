part of 'widgets_imports.dart';

class StatisticItem extends StatelessWidget {
  final String title;
  final String value;
  const StatisticItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
