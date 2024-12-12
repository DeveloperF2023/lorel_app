import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/global/widgets_imports.dart';
import '../../widgets/registration/widgets_imports.dart';

class RegistrationCourseScreen extends StatefulWidget {
  final String selectedDiplomas;
  final String formationId;
  const RegistrationCourseScreen(
      {super.key, required this.selectedDiplomas, required this.formationId});

  @override
  State<RegistrationCourseScreen> createState() =>
      _RegistrationCourseScreenState();
}

class _RegistrationCourseScreenState extends State<RegistrationCourseScreen> {
  @override
  void initState() {
    debugPrint("Selected Diploma: ${widget.selectedDiplomas}");
    debugPrint("formationId: ${widget.formationId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                    right:
                        AppLocalization.of(context)!.isArabicSelected(context)
                            ? 10.w
                            : 0.w,
                    child: Row(
                      mainAxisAlignment:
                          AppLocalization.of(context)!.isArabicSelected(context)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        BackButtonWidget(
                          backgroundColor: Colors.white,
                          iconColor: AppColors.primaryColor,
                          onTap: () => Navigator.pop(context),
                        ),
                        SizedBox(
                          width: 70.w,
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
                      height: HelperFunctions.screenHeight(context) > 840.17
                          ? HelperFunctions.screenHeight(context) * .75.h
                          : HelperFunctions.screenHeight(context) * .74.h,
                      width: HelperFunctions.screenWidth(context).w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r),
                          )),
                      child: RegistrationForm(
                        selectedDiploma: widget.selectedDiplomas,
                        formationId: widget.formationId,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
