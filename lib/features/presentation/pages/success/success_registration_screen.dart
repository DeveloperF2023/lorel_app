import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/success/widgets_imports.dart';

class SuccessRegistrationScreen extends StatelessWidget {
  const SuccessRegistrationScreen({super.key});

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
              top: 25.h,
              left: 0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    backgroundColor: Colors.white,
                    iconColor: AppColors.primaryColor,
                    onTap: () => Navigator.pushReplacementNamed(
                        context, NavigationStrings.allCourses),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    AppLocalization.of(context)!.translate("register"),
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
                child: const SuccessRegistrationContent(),
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
                          color: Colors.grey,
                          blurRadius: 8,
                          offset: Offset(1, 1))
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
      ),
    );
  }
}
