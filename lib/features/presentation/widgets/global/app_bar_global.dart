part of 'widgets_imports.dart';

class AppBarGlobal extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String title;
  final Color? titleColor;
  final bool? isActions;
  final Color? backgroundColorBackButton;
  final Color? iconColor;
  const AppBarGlobal(
      {super.key,
      this.backgroundColor,
      required this.title,
      this.titleColor,
      this.isActions,
      this.backgroundColorBackButton,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Padding(
          padding: EdgeInsets.only(
              left: !AppLocalization.of(context)!.isArabicSelected(context)
                  ? 5.w
                  : 0.w,
              right: AppLocalization.of(context)!.isArabicSelected(context)
                  ? 5.w
                  : 0.w),
          child: BackButtonWidget(
            backgroundColor: backgroundColorBackButton!,
            iconColor: iconColor!,
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.robotoCondensed(fontSize: 24.sp, color: titleColor),
      ),
      centerTitle: true,
      actions: isActions == true
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, NavigationStrings.notification);
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ))
            ]
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 70);
}
