part of 'widgets_imports.dart';

class FavoriteContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String company;
  final String nature;
  final int period;
  final String units;
  final int offerId;
  const FavoriteContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.company,
    required this.nature,
    required this.period,
    required this.units,
    required this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company,
                    style: GoogleFonts.robotoCondensed(
                        color: AppColors.secondarySmokeyGrey, fontSize: 20.sp),
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
                        "$period ${units == "months" ? AppLocalization.of(context)!.translate("months") : units == "years" ? AppLocalization.of(context)!.translate("years") : AppLocalization.of(context)!.translate("days")}",
                        style: GoogleFonts.robotoCondensed(
                            color: AppColors.gullGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<FavoriteStatusCubit, bool>(
            builder: (context, isFavorite) {
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.primaryColor : Colors.grey,
                  size: 35.sp,
                ),
                onPressed: () {
                  if (isFavorite) {
                    context
                        .read<RemoveFromFavoriteListCubit>()
                        .deleteFromFavoriteList(offerId: offerId)
                        .then((_) {
                      context.read<FavoriteStatusCubit>().updateStatus(false);
                    });
                  } else {
                    context
                        .read<AddToFavoriteListCubit>()
                        .addToFavoriteList(offerId: offerId)
                        .then((_) {
                      context.read<FavoriteStatusCubit>().updateStatus(true);
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
