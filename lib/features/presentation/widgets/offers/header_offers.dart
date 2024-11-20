part of 'widgets_imports.dart';

class HeaderOffers extends StatelessWidget {
  final TextEditingController searchController;
  final Function(bool) onSearchChanged; // Callback to notify search status

  const HeaderOffers({
    super.key,
    required this.searchController,
    required this.onSearchChanged, // Add this to the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButtonWidget(
                backgroundColor: Colors.white,
                iconColor: AppColors.primaryColor,
                onTap: () => Navigator.pop(context),
              ),
              Text(
                AppLocalization.of(context)!.translate("offers"),
                style: GoogleFonts.robotoCondensed(
                    fontSize: 24.sp, color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NavigationStrings.notification);
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 75.h,
          width: HelperFunctions.screenWidth(context),
          color: AppColors.primaryColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                height: 40.h,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context
                          .read<SearchOffersCubit>()
                          .searchOffer(query: value);
                      onSearchChanged(true); // Notify that search is active
                    } else {
                      context.read<SearchOffersCubit>().clearSearch();
                      onSearchChanged(false); // Notify that search is cleared
                    }
                  },
                  decoration: InputDecoration(
                    hintText:
                        AppLocalization.of(context)!.translate("searchHere"),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.darkGrey,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.darkGrey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: HelperFunctions.screenWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ToggleOffersWidget(),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NavigationStrings.favorites);
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
