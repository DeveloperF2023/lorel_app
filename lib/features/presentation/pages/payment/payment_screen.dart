import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/global/widgets_imports.dart';
import '../../widgets/payment/widgets_imports.dart';

class PaymentScreen extends StatelessWidget {
  final String? selectedDiploma;
  final String formationId;
  const PaymentScreen(
      {super.key, required this.selectedDiploma, required this.formationId});

  @override
  Widget build(BuildContext context) {
    debugPrint("The selected diploma: $selectedDiploma");
    debugPrint("Formation ID: $formationId");
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
              right: 50.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(
                      backgroundColor: Colors.white,
                      iconColor: AppColors.primaryColor,
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final token = prefs.getString("token");
                        if (token == null && context.mounted) {
                          Navigator.pushReplacementNamed(
                              context, NavigationStrings.registrationCourse,
                              arguments: {
                                "selectedDiplomas": selectedDiploma,
                                "formationId": formationId
                              });
                        } else {
                          Navigator.pushReplacementNamed(
                              context, NavigationStrings.allCourses);
                        }
                      }),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    AppLocalization.of(context)!.translate("manualPayment"),
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
                height: HelperFunctions.screenHeight(context) * .74.h,
                width: HelperFunctions.screenWidth(context).w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r),
                    )),
                child: PaymentContent(
                  selectedDiploma: selectedDiploma ?? "maroc",
                  formationId: formationId,
                ),
              )),
        ],
      ),
    );
  }
}
