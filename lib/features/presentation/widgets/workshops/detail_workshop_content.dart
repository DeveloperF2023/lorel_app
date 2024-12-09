part of 'widgets_imports.dart';

class DetailWorkshopContent extends StatelessWidget {
  final WorkshopEntity workshop;

  const DetailWorkshopContent({
    super.key,
    required this.workshop,
  });

  @override
  Widget build(BuildContext context) {
    int? priceAsInt;
    try {
      priceAsInt = double.tryParse(workshop.price!)?.toInt();
    } catch (e) {
      priceAsInt = null; // Handle parsing error if necessary
    }
    final dateTo = DateFormat('yyyy-MM-dd').parse(workshop.dateTo!);
    debugPrint('Date To $dateTo');
    final dateFrom = DateFormat('yyyy-MM-dd').parse(workshop.dateFrom!);
    debugPrint("Date From ${dateFrom.day}");
    debugPrint("Date To ${dateTo.day}");
    DateTime parsedDateFrom =
        DateTime(DateTime.now().year, DateTime.now().month, dateFrom.day);
    DateTime parsedDateTo =
        DateTime(DateTime.now().year, DateTime.now().month, dateTo.day);
    debugPrint("Parsed date to $parsedDateTo");
    String monthFrom = AppLocalization.of(context)!.isArabicSelected(context)
        ? DateFormat('MMM', 'ar').format(parsedDateFrom).toUpperCase()
        : DateFormat('MMM').format(parsedDateFrom).toUpperCase();

    String monthTo = AppLocalization.of(context)!.isArabicSelected(context)
        ? DateFormat('MMM', 'ar').format(parsedDateTo).toUpperCase()
        : DateFormat('MMM').format(parsedDateTo).toUpperCase();
    debugPrint("Month To $monthTo");

    Future<void> openUrl(String link) async {
      if (await canLaunchUrl(Uri.parse(link))) {
        await launchUrl(Uri.parse(link));
      } else {
        throw 'Could not launch Zoom';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonWidget(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, NavigationStrings.workshop),
                      ),
                      Text(
                        AppLocalization.of(context)!.translate("conference"),
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                        ),
                      ),
                      const Icon(
                        Icons.notifications,
                        color: AppColors.darkGrey,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: HelperFunctions.screenHeight(context) * .25.h,
                  width: HelperFunctions.screenWidth(context),
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(workshop.image!))),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workshop.title!,
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            workshop.address!,
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      workshop.free == true
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
                            "${dateFrom.day} $monthFrom - ${dateTo.day} $monthTo",
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
                            workshop.participantsCount.toString(),
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
                        workshop.description!,
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
                        workshop.about!,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        LearnMoreButton(onTap: () {
          openUrl(workshop.link!);
        })
      ],
    );
  }
}
