part of 'widgets_imports.dart';

class OffersContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String company;
  final String nature;
  final int period;
  final String units;
  final void Function()? onFetchDetailOffer;
  final bool? isFavorites;

  const OffersContent(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.company,
      required this.nature,
      required this.period,
      required this.units,
      this.onFetchDetailOffer,
      this.isFavorites = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onFetchDetailOffer,
                child: CircleAvatar(
                  radius: 35.r,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: onFetchDetailOffer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: GoogleFonts.robotoCondensed(
                          color: AppColors.secondarySmokeyGrey,
                          fontSize: 20.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppLocalization.of(context)!.translate("job")} : ",
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          title,
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppLocalization.of(context)!.translate("typeOfInternship")} : ",
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          nature,
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${AppLocalization.of(context)!.translate("duration")} : ",
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "$period ${units == "month" ? AppLocalization.of(context)!.translate("months") : units == "year" ? AppLocalization.of(context)!.translate("years") : AppLocalization.of(context)!.translate("days")}",
                          style: GoogleFonts.robotoCondensed(
                              color: AppColors.gullGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onFetchDetailOffer,
            child: Icon(
              isFavorites == false
                  ? Icons.arrow_forward_ios_outlined
                  : Icons.favorite,
              color: isFavorites == false ? AppColors.gullGrey : Colors.red,
              size: isFavorites == false ? 20.sp : 32.sp,
            ),
          )
        ],
      ),
    );
  }
}
