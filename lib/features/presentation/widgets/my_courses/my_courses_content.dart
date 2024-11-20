part of 'widgets_imports.dart';

class MyCoursesContent extends StatelessWidget {
  final void Function()? onTap;
  final CoursesByStatusEntity myCourses;

  const MyCoursesContent({
    super.key,
    this.onTap,
    required this.myCourses,
  });

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(myCourses.startAt!);
    int periode = myCourses.periode!;
    DateTime currentDate = DateTime.now();

// Function to add months safely
    DateTime addMonths(DateTime date, int months) {
      int newYear = date.year + ((date.month + months - 1) ~/ 12);
      int newMonth = (date.month + months - 1) % 12 + 1;
      int day = date.day;

      // Adjust day if the new month has fewer days
      int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
      if (day > lastDayOfNewMonth) {
        day = lastDayOfNewMonth;
      }

      return DateTime(newYear, newMonth, day);
    }

    DateTime endDate = addMonths(startDate, periode);

// Calculate total remaining days
    int totalRemainingDays = endDate.difference(currentDate).inDays;
    int remainingMonths =
        (totalRemainingDays / 30).floor(); // Full remaining months
    int remainingDays =
        totalRemainingDays % 30; // Remaining days after full months

// Ensure non-negative values
    remainingMonths = remainingMonths < 0 ? 0 : remainingMonths;
    remainingDays = remainingDays < 0 ? 0 : remainingDays;

// Display only months or only days based on remaining time
    String remainingTimeText;
    if (remainingMonths > 0) {
      remainingTimeText =
          "$remainingMonths ${AppLocalization.of(context)!.translate('months')}";
    } else {
      remainingTimeText =
          "$remainingDays ${AppLocalization.of(context)!.translate('days')}";
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 101.h,
        width: HelperFunctions.screenWidth(context) * .95.w,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(1, 1)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 110.w,
              height: 101.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft:
                      AppLocalization.of(context)!.isArabicSelected(context)
                          ? Radius.circular(0.r)
                          : Radius.circular(25.r),
                  topRight:
                      AppLocalization.of(context)!.isArabicSelected(context)
                          ? Radius.circular(25.r)
                          : Radius.circular(0.r),
                  bottomLeft:
                      AppLocalization.of(context)!.isArabicSelected(context)
                          ? Radius.circular(0.r)
                          : Radius.circular(25.r),
                  bottomRight:
                      AppLocalization.of(context)!.isArabicSelected(context)
                          ? Radius.circular(25.r)
                          : Radius.circular(0.r),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(myCourses.image!),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        myCourses.title!,
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context)!.translate('category'),
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            myCourses.status == "in_progress"
                                ? AppLocalization.of(context)!
                                    .translate("inProgress")
                                : AppLocalization.of(context)!
                                    .translate("finished"),
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: double.parse(myCourses.progress!),
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "${myCourses.progress!}%",
                          style: GoogleFonts.poppins(
                              color: AppColors.lightSlateGrey, fontSize: 9.sp),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${AppLocalization.of(context)!.translate('duration')} : ",
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: HelperFunctions.screenWidth(
                                                  context) ==
                                              384.0
                                          ? 8.sp
                                          : 7.sp,
                                      color: AppColors.lightSlateGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${myCourses.periode} ${myCourses.units == "months" ? AppLocalization.of(context)!.translate('months') : myCourses.units == "years" ? AppLocalization.of(context)!.translate('years') : AppLocalization.of(context)!.translate('days')}",
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: HelperFunctions.screenWidth(
                                                  context) ==
                                              384.0
                                          ? 8.sp
                                          : 7.sp,
                                      color: AppColors.lightSlateGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "${AppLocalization.of(context)!.translate('remaining')} : ",
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: HelperFunctions.screenWidth(
                                                    context) ==
                                                384.0
                                            ? 8.sp
                                            : 7.sp,
                                        color: AppColors.lightSlateGrey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      remainingTimeText,
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: HelperFunctions.screenWidth(
                                                    context) ==
                                                384.0
                                            ? 8.sp
                                            : 7.sp,
                                        color: AppColors.lightSlateGrey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
