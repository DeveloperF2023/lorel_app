part of 'widgets_imports.dart';

class DetailWorkshopContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String address;
  final bool free;
  final String price;
  final int dateTo;
  final int dateFrom;
  final String month;
  final int participantsCount;
  final String description;
  final String about;

  const DetailWorkshopContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.free,
    required this.price,
    required this.dateTo,
    required this.dateFrom,
    required this.month,
    required this.participantsCount,
    required this.description,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    int? priceAsInt;
    try {
      priceAsInt = double.tryParse(price)?.toInt();
    } catch (e) {
      priceAsInt = null; // Handle parsing error if necessary
    }
    DateTime parsedDateFrom =
        DateTime(DateTime.now().year, DateTime.now().month, dateFrom);
    DateTime parsedDateTo = DateTime(dateTo);

    String monthFrom = AppLocalization.of(context)!.isArabicSelected(context)
        ? DateFormat('MMM', 'ar').format(parsedDateFrom).toUpperCase()
        : DateFormat('MMM').format(parsedDateFrom).toUpperCase();

    String monthTo = AppLocalization.of(context)!.isArabicSelected(context)
        ? DateFormat('MMM', 'ar').format(parsedDateTo).toUpperCase()
        : DateFormat('MMM').format(parsedDateTo).toUpperCase();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(
                    AppLocalization.of(context)!.translate("conference"),
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    color: AppColors.darkGrey,
                  )
                ],
              ),
            ),
            Container(
              height: HelperFunctions.screenHeight(context) * .25.h,
              width: HelperFunctions.screenWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imageUrl))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        address,
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  free == true
                      ? Text(
                          AppLocalization.of(context)!.translate("free"),
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        )
                      : Text(
                          "${priceAsInt.toString()} DH",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${AppLocalization.of(context)!.translate("date")}: ",
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: AppColors.secondarySmokeyGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "$dateFrom $monthFrom - $dateTo $monthTo",
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: AppColors.secondarySmokeyGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppLocalization.of(context)!.translate('participants')} :",
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: AppColors.secondarySmokeyGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        participantsCount.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: AppColors.secondarySmokeyGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppLocalization.of(context)!.translate('description')} :",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppLocalization.of(context)!.translate('aboutEvent')} :",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    about,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          height: 66.h,
          decoration: const BoxDecoration(color: AppColors.secondaryMercury),
          child: Center(
            child: Container(
              height: 42.h,
              margin: EdgeInsets.symmetric(horizontal: 55.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.butterFlyBlue),
              child: Center(
                child: Text(
                  AppLocalization.of(context)!.translate("learnMore"),
                  style:
                      GoogleFonts.poppins(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
