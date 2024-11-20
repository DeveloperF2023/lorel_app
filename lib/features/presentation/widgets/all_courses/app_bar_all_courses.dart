part of 'widgets_imports.dart';

class AppBarAllCourses extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String? title;
  const AppBarAllCourses(
      {super.key, this.backgroundColor = Colors.white, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(
            right: AppLocalization.of(context)!.isArabicSelected(context)
                ? 10.w
                : 0.w,
            left: AppLocalization.of(context)!.isArabicSelected(context)
                ? 0.w
                : 10.w),
        child: BackButtonWidget(
          onTap: () => Navigator.pop(context),
        ),
      ),
      automaticallyImplyLeading: false,
      title: Text(
        title!,
        style:
            GoogleFonts.poppins(fontSize: 18.sp, color: AppColors.charcoalGrey),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(0, 60);
}
