import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_test_online/core/constants/app_colors.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/features/presentation/widgets/global/widgets_imports.dart';

import '../../../../core/routes/routes.dart';
import '../../../../dependencies_injection.dart';
import '../../manager/offers/add_to_favorite_list/add_to_favorite_list_cubit.dart';
import '../../manager/offers/favorite_status_cubit.dart';
import '../../manager/offers/get_detail_offer/get_detail_offer_cubit.dart';
import '../../manager/offers/remove_from_favorite_list/remove_from_favorite_list_cubit.dart';
import '../../widgets/offers/widgets_imports.dart';

class DetailOfferScreen extends StatelessWidget {
  final int offerId;
  final bool initialFavoriteStatus;
  const DetailOfferScreen(
      {super.key, required this.offerId, required this.initialFavoriteStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.soapstone,
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: EdgeInsets.only(
              left: !AppLocalization.of(context)!.isArabicSelected(context)
                  ? 10.w
                  : 0.w,
              right: AppLocalization.of(context)!.isArabicSelected(context)
                  ? 10.w
                  : 0.w),
          child: BackButtonWidget(onTap: () => Navigator.pop(context)),
        ),
        title: Text(
          AppLocalization.of(context)!.translate("offers"),
          style: GoogleFonts.robotoCondensed(
              fontSize: 24.sp, color: AppColors.riverBed),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NavigationStrings.notification);
              },
              icon: Icon(
                Icons.notifications,
                color: AppColors.darkGrey,
              ))
        ],
      ),
      body: SafeArea(
          child: MultiBlocProvider(
              providers: [
            BlocProvider(
              create: (context) => locator<GetDetailOfferCubit>()
                ..getDetailOffer(offerId: offerId),
            ),
            BlocProvider(
              create: (context) => locator<AddToFavoriteListCubit>(),
            ),
            BlocProvider(
              create: (context) => locator<RemoveFromFavoriteListCubit>(),
            ),
            BlocProvider(
              create: (context) => FavoriteStatusCubit(initialFavoriteStatus),
            ),
          ],
              child: BlocBuilder<GetDetailOfferCubit, GetDetailOfferState>(
                builder: (context, state) {
                  if (state is GetDetailOfferLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetDetailOfferLoaded) {
                    final detailOffer = state.offer;
                    return DetailOfferContent(
                      imageUrl: detailOffer.image!,
                      title: detailOffer.title!,
                      company: detailOffer.company!,
                      city: detailOffer.city!,
                      salary: detailOffer.salary!,
                      contract: detailOffer.contract!,
                      missions: detailOffer.missions!,
                      skills: detailOffer.skills!,
                      experience: detailOffer.experience!,
                      offerId: detailOffer.id!,
                      isFavorite: detailOffer.ifFavorite!,
                    );
                  } else if (state is GetDetailOfferFailure) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ))),
    );
  }
}
