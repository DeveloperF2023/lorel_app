part of 'widgets_imports.dart';

class SettingsTile extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;
  final String title;
  final IconData leading;
  const SettingsTile(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.title,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              leading,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: GoogleFonts.robotoCondensed(
                color: AppColors.carbonGrey,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.black,
            size: 18.sp,
          ),
        ),
      ],
    );
  }
}
