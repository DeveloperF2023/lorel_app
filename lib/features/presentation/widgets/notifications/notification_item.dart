part of 'widgets_imports.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String dateTimeNotification;
  final String description;
  final void Function()? onTap;
  const NotificationItem(
      {super.key,
      required this.title,
      required this.description,
      this.onTap,
      required this.dateTimeNotification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: HelperFunctions.screenWidth(context) * .9.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.black),
            color: AppColors.teaGreen.withOpacity(0.2)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: HelperFunctions.screenWidth(context) * .88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        DateFormat.yMd()
                            .format(DateTime.parse(dateTimeNotification)),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: HelperFunctions.screenWidth(context) * .77.w,
                  child: Text(
                    HelperFunctions.truncateText(description, 150),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
