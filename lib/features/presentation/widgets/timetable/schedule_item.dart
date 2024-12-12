part of 'widgets_imports.dart';

class ScheduleItem extends StatelessWidget {
  final String day;
  final String courseName;
  final String startTime;
  final String endTime;
  final String domainName;
  final String teacher;
  const ScheduleItem(
      {super.key,
      required this.day,
      required this.courseName,
      required this.startTime,
      required this.endTime,
      required this.domainName,
      required this.teacher});

  @override
  Widget build(BuildContext context) {
    String formattedStartTime = startTime.substring(0, 5);
    String formattedEndTime = endTime.substring(0, 5);
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getDayOfWeek(day, context),
            style: GoogleFonts.robotoCondensed(
                color: AppColors.sapphireBlue, fontSize: 20.sp),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 80.h,
            decoration: BoxDecoration(
                color: getCourseColor(courseName),
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                SizedBox(
                  height: 45.h,
                  width: 30.w,
                  child: VerticalDivider(
                    color: getDividerColorByCourseName(courseName),
                    thickness: 2,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: HelperFunctions.screenWidth(context) * .7.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            courseName,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 18.sp,
                                color: AppColors.secondarySmokeyGrey),
                          ),
                          Text(
                            "$formattedStartTime - $formattedEndTime",
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 13.sp,
                                color: AppColors.secondarySmokeyGrey,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: HelperFunctions.screenWidth(context) * .7.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            domainName,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 13.sp,
                                color: AppColors.secondarySmokeyGrey,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            teacher,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 13.sp,
                                color: AppColors.secondarySmokeyGrey,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getDayOfWeek(String day, BuildContext context) {
    String translatedDay;
    switch (day.toLowerCase()) {
      case "monday":
        translatedDay = AppLocalization.of(context)!.translate('monday');
        break;
      case "tuesday":
        translatedDay = AppLocalization.of(context)!.translate('tuesday');
        break;
      case "wednesday":
        translatedDay = AppLocalization.of(context)!.translate('wednesday');
        break;
      case "thursday":
        translatedDay = AppLocalization.of(context)!.translate('thursday');
        break;
      case "friday":
        translatedDay = AppLocalization.of(context)!.translate('friday');
        break;
      case "saturday":
        translatedDay = AppLocalization.of(context)!.translate('saturday');
        break;
      case "sunday":
        translatedDay = AppLocalization.of(context)!.translate('sunday');
        break;
      default:
        translatedDay = "Invalid day";
    }

    debugPrint('Day: $day, Translated: $translatedDay');
    return translatedDay;
  }
}
