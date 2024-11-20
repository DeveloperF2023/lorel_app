import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_assets.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class LanguageScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  const LanguageScreen({super.key, required this.onLocaleChange});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: HelperFunctions.screenHeight(context) * .86.h,
            width: HelperFunctions.screenWidth(context).w,
            color: AppColors.primaryColor,
          ),
          Positioned(
              top: 40.h,
              left: 50.w,
              right: 50.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Languages",
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
                height: HelperFunctions.screenHeight(context) * .72.h,
                width: HelperFunctions.screenWidth(context).w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r),
                    )),
              )),
          Positioned(
              top: HelperFunctions.screenHeight(context) * .2.h,
              left: 20.w,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 60.h, right: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: HelperFunctions.screenWidth(context) * .7.w,
                      child: Text(
                        "Choose your language for a personalized experience",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onLocaleChange(const Locale('en', ''));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          NavigationStrings.login,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.english,
                            height: 50.h,
                            width: 50.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "English",
                            style: GoogleFonts.robotoCondensed(fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onLocaleChange(const Locale('fr', ''));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          NavigationStrings.login,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.french,
                            height: 50.h,
                            width: 50.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "French",
                            style: GoogleFonts.robotoCondensed(fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onLocaleChange(const Locale('ar', ''));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          NavigationStrings.login,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.arabic,
                            height: 50.h,
                            width: 50.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Arabic",
                            style: GoogleFonts.robotoCondensed(fontSize: 20.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
