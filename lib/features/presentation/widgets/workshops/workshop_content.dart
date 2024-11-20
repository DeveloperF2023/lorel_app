part of 'widgets_imports.dart';

class WorkshopContent extends StatelessWidget {
  final String dateFrom;
  final String title;
  final int participantsCount;
  final String price;
  final void Function()? onFetchWorkshopDetail;
  const WorkshopContent(
      {super.key,
      required this.dateFrom,
      required this.title,
      required this.participantsCount,
      required this.price,
      this.onFetchWorkshopDetail});

  @override
  Widget build(BuildContext context) {
    int? priceAsInt;
    try {
      priceAsInt = double.tryParse(price)?.toInt();
    } catch (e) {
      // Handle parsing error if necessary
      priceAsInt = null;
    }
    Locale currentLocale = Localizations.localeOf(context);
    DateTime date = _parseDate(dateFrom, context);
    String lastTwoDigitsOfYear = (date.year % 100).toString().padLeft(2, '0');
    DateTime parsedDate = DateUtil.parseDate(dateFrom, currentLocale);

    // Format the day and year
    String dayAndYear = DateUtil.formatDate(parsedDate, 'd', currentLocale) +
        (currentLocale.languageCode == 'ar' ? ' - ' : '-') +
        lastTwoDigitsOfYear;

    // Format the month in uppercase
    String month =
        DateUtil.formatDate(parsedDate, 'MMM', currentLocale).toUpperCase();
    return GestureDetector(
      onTap: onFetchWorkshopDetail,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        margin: EdgeInsets.only(bottom: 5.h, left: 10.w, right: 10.w, top: 5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r), color: Colors.white),
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
                    dayAndYear,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.marbleBlue,
                    ),
                  ),
                  Text(
                    month,
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 18.sp,
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
                  title,
                  style: GoogleFonts.robotoCondensed(
                      color: AppColors.secondarySmokeyGrey,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: HelperFunctions.screenWidth(context) * .68.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.solidUser,
                            color: AppColors.gullGrey,
                            size: 15.sp,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            participantsCount.toString(),
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 16.sp, color: AppColors.gullGrey),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${AppLocalization.of(context)!.translate("price")}: ",
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 16.sp, color: AppColors.gullGrey),
                          ),
                          Text(
                            "${priceAsInt != null ? priceAsInt.toString() : AppLocalization.of(context)!.translate("free")} ${priceAsInt == null ? "" : "${AppLocalization.of(context)!.translate("dirham")}"}",
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 16.sp, color: AppColors.gullGrey),
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

  DateTime _parseDate(String dateString, BuildContext context) {
    try {
      // Determine if Arabic is selected
      bool isArabic = AppLocalization.of(context)!.isArabicSelected(context);

      // Choose the correct locale
      String locale = isArabic ? 'ar' : 'fr'; // Use 'fr' for French

      // Define the date format with the appropriate locale
      DateFormat dateFormat = DateFormat('d MMMM y', locale);

      // Parse the date string
      return dateFormat.parse(dateString);
    } catch (e) {
      // Handle parsing errors gracefully
      print("Error parsing date: $e");
      // Optionally, return a default date or handle the error as needed
      return DateTime.now(); // Fallback date
    }
  }
}
