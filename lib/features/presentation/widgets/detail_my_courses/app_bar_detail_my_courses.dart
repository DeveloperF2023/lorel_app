part of 'widgets_imports.dart';

class AppBarDetailMyCourse extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String? title;
  const AppBarDetailMyCourse(
      {super.key, this.backgroundColor = Colors.white, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
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
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 60);
}
