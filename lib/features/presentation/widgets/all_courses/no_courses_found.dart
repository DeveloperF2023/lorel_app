import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/helpers/locale_service.dart';

class NoCoursesFound extends StatelessWidget {
  const NoCoursesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HelperFunctions.screenHeight(context) > 840
          ? HelperFunctions.screenHeight(context) * .6.h
          : HelperFunctions.screenHeight(context) * .655.h,
      width: HelperFunctions.screenWidth(context) * .9.w,
      child: Center(
        child: Text(
          AppLocalization.of(context)!.translate("noCoursesFound"),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
