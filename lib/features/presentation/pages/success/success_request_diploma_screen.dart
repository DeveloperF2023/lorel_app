import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/success/widgets_imports.dart';

class SuccessRequestDiplomaScreen extends StatelessWidget {
  const SuccessRequestDiplomaScreen({super.key});

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
              left: 10.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    backgroundColor: Colors.white,
                    iconColor: AppColors.primaryColor,
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    "S’Inscrire",
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
                child: SuccessRegistrationContent(),
              )),
        ],
      ),
    );
  }
}
