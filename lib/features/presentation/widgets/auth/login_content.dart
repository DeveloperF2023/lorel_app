part of 'widgets_imports.dart';

class LoginContent extends StatefulWidget {
  bool isSignIn;
  LoginContent({super.key, required this.isSignIn});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  Locale _locale = const Locale("en");
  void _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode); // Save language code
    setState(() {
      _locale = locale;
    });
    MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: HelperFunctions.screenHeight(context) * .86.h,
          width: HelperFunctions.screenWidth(context).w,
          color: AppColors.primaryColor,
        ),
        Positioned(
            top: 25.h,
            left: AppLocalization.of(context)!.isArabicSelected(context)
                ? 0.w
                : 10.w,
            right: AppLocalization.of(context)!.isArabicSelected(context)
                ? 10.w
                : 0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackButtonWidget(
                  backgroundColor: Colors.white,
                  iconColor: AppColors.primaryColor,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LanguageScreen(onLocaleChange: _changeLanguage))),
                ),
                SizedBox(
                  width: 35.w,
                ),
                Text(
                  AppLocalization.of(context)!.translate('welcomeToApp'),
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 24.sp, color: Colors.white),
                ),
              ],
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: HelperFunctions.screenHeight(context) >= 840.17
                  ? HelperFunctions.screenHeight(context) * .7.h
                  : HelperFunctions.screenHeight(context) * .72.h,
              width: HelperFunctions.screenWidth(context).w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    topLeft: Radius.circular(30.r),
                  )),
              child: FormAuth(
                isSignIn: widget.isSignIn,
              ),
            )),
        Positioned(
            top: 80.h,
            left: 100.w,
            right: 100.w,
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 8, offset: Offset(1, 1))
                  ]),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.solidUser,
                  color: AppColors.darkGrey,
                  size: 25.sp,
                ),
              ),
            )),
      ],
    );
  }
}
