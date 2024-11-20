part of 'widgets_imports.dart';

class CoursesContent extends StatelessWidget {
  final String additionalDiploma;
  final void Function()? onTap;
  final CoursesEntity courses;

  const CoursesContent({
    super.key,
    required this.additionalDiploma,
    this.onTap,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 159.h,
        margin: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w),
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
              width: 153.w,
              height: 159.h,
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
                  image: NetworkImage(courses.image!),
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
                        HelperFunctions.truncateText(
                            courses.title!.toUpperCase(), 20),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16.sp,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      HelperFunctions.truncateText(courses.description!, 70),
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (courses.additionalDiplomas != null)
                            Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context)!.translate("certificate")}: ",
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  additionalDiploma,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: AppLocalization.of(context)!
                                        .isArabicSelected(context)
                                    ? 5.w
                                    : 0.w,
                                right: AppLocalization.of(context)!
                                        .isArabicSelected(context)
                                    ? 0.w
                                    : 0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${AppLocalization.of(context)!.translate("duration")} : ",
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: HelperFunctions.screenWidth(
                                                    context) >=
                                                384.0.w
                                            ? 10.sp
                                            : 8.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "${courses.periode} ${courses.units == "months" ? AppLocalization.of(context)!.translate("months") : courses.units == "years" ? AppLocalization.of(context)!.translate("years") : AppLocalization.of(context)!.translate("days")}",
                                      style: GoogleFonts.robotoCondensed(
                                        fontSize: HelperFunctions.screenWidth(
                                                    context) >
                                                384.0.w
                                            ? 10.sp
                                            : 8.sp,
                                        color: Colors.black,
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
                                        "${AppLocalization.of(context)!.translate("price")}: ",
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: HelperFunctions.screenWidth(
                                                      context) >
                                                  384.0.w
                                              ? 10.sp
                                              : 8.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        "${courses.price} DH",
                                        style: GoogleFonts.robotoCondensed(
                                          fontSize: HelperFunctions.screenWidth(
                                                      context) >
                                                  384.0.w
                                              ? 10.sp
                                              : 8.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: AppColors.mariner,
                                  borderRadius: BorderRadius.circular(11.r),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalization.of(context)!
                                        .translate("register"),
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 13.sp,
                                      color: Colors.white,
                                    ),
                                  ),
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
