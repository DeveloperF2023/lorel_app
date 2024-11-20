part of 'widgets_imports.dart';

class MyCoursesNotFound extends StatelessWidget {
  const MyCoursesNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HelperFunctions.screenHeight(context) * .65,
      width: HelperFunctions.screenWidth(context).w,
      margin: EdgeInsets.only(left: 10.w, bottom: 10.h, right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white),
        color: AppColors.jungleMist.withOpacity(0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.circleInfo,
            color: AppColors.darkGrey,
            size: 35.sp,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppLocalization.of(context)!.translate('noCourses'),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.darkGrey,
            ),
          )
        ],
      ),
    );
  }
}
