part of 'widgets_imports.dart';

class LiveItem extends StatelessWidget {
  final void Function() onFetchLives;
  final LivesEntity lives;
  const LiveItem({super.key, required this.onFetchLives, required this.lives});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFetchLives,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        margin: EdgeInsets.only(bottom: 5.h, left: 10.w, right: 10.w, top: 5.h),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: !AppLocalization.of(context)!.isArabicSelected(context)
                      ? 10.w
                      : 0.w,
                  right: AppLocalization.of(context)!.isArabicSelected(context)
                      ? 10.w
                      : 0.w),
              child: Column(
                children: [
                  Text(
                    DateFormat.Md().format(DateTime.parse(lives.startTime!)),
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.marbleBlue,
                    ),
                  ),
                  Text(
                    lives.zoomResponse?.status == true
                        ? "Available"
                        : "Not Available",
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.marbleBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              height: 45.h,
              child: const VerticalDivider(
                color: AppColors.jordyBlue,
                thickness: 1.5,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lives.title!,
                  style: GoogleFonts.robotoCondensed(
                      color: AppColors.secondarySmokeyGrey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: HelperFunctions.screenWidth(context) * .6.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: AppColors.gullGrey,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${(lives.zoomResponse!.data!.duration! ~/ 60)}h ${(lives.zoomResponse!.data!.duration! % 60) ~/ 60}m",
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 16.sp, color: AppColors.gullGrey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            lives.zoomResponse!.data!.timezone!,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 14.sp, color: AppColors.gullGrey),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
