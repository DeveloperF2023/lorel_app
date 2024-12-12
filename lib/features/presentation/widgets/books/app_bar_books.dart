part of 'widgets_imports.dart';

class AppBarBooks extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(
            left: AppLocalization.of(context)!.isArabicSelected(context)
                ? 0.w
                : 10.w,
            right: AppLocalization.of(context)!.isArabicSelected(context)
                ? 10.w
                : 0.w),
        child: BackButtonWidget(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString("token");
            if (token != null && context.mounted) {
              Navigator.pushReplacementNamed(context, NavigationStrings.main,
                  arguments: token);
            } else {
              debugPrint("Token it's null ");
            }
          },
        ),
      ),
      title: Text(
        AppLocalization.of(context)!.translate("books"),
        style: GoogleFonts.robotoCondensed(
          fontSize: 22.sp,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NavigationStrings.notification);
            },
            icon: const Icon(
              Icons.notifications,
              color: AppColors.darkerGrey,
            ))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(0, 70);
}
