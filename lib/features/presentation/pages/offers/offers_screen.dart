import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/routes/routes.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../dependencies_injection.dart';
import '../../manager/offers/get_offers_by_type/get_offers_by_type_cubit.dart';
import '../../manager/offers/search_offers/search_offers_cubit.dart';
import '../../manager/offers/toggle_offers/toggle_offers_cubit.dart';
import '../../widgets/offers/widgets_imports.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearch = false; // This should be mutable, without 'final'

  @override
  void initState() {
    super.initState();
    // Initialize the default offer list
    context.read<GetOffersByTypeCubit>().getOffersByType(type: 'internship');
  }

  // This method is no longer needed since 'onChanged' directly handles the logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => locator<GetOffersByTypeCubit>()
                ..getOffersByType(type: 'internship'),
            ),
            BlocProvider(
              create: (context) => ToggleOffersCubit()..toggleButton(0),
            ),
            BlocProvider(
              create: (context) => locator<SearchOffersCubit>(),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: HelperFunctions.screenHeight(context) > 840
                          ? HelperFunctions.screenHeight(context) * .83.h
                          : HelperFunctions.screenHeight(context) * .86.h,
                      width: HelperFunctions.screenWidth(context).w,
                      color: AppColors.primaryColor,
                    ),
                    Positioned(
                      top: 25.h,
                      left: 0.w,
                      right: 0.w,
                      child: HeaderOffers(
                        searchController: searchController,
                        onSearchChanged: (isSearching) {
                          setState(() {
                            isSearch = isSearching;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: HelperFunctions.screenHeight(context) * .6.h,
                        width: HelperFunctions.screenWidth(context).w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r),
                          ),
                        ),
                        child: isSearch
                            ? BlocBuilder<SearchOffersCubit, SearchOffersState>(
                                builder: (context, state) {
                                  if (state is SearchOffersLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.primaryColor),
                                    );
                                  } else if (state is SearchOffersLoaded) {
                                    return ListView.separated(
                                      itemCount: state.searchOffers.length,
                                      itemBuilder: (context, index) {
                                        final offer = state.searchOffers[index];
                                        return OffersContent(
                                          imageUrl: offer.image!,
                                          title: offer.title!,
                                          company: offer.company!,
                                          nature: offer.nature!,
                                          period: offer.periode!,
                                          units: offer.unit!,
                                          onFetchDetailOffer: () {
                                            Navigator.pushNamed(context,
                                                NavigationStrings.detailOffer,
                                                arguments: {
                                                  "offerId": offer.id,
                                                  "isFavorite": offer.isFavorite
                                                });
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: 13.h,
                                          color: const Color(0xffe6ebef),
                                        );
                                      },
                                    );
                                  } else if (state is SearchOffersFailure) {
                                    return Center(child: Text(state.message));
                                  }
                                  return Container();
                                },
                              )
                            : BlocBuilder<GetOffersByTypeCubit,
                                GetOffersByTypeState>(
                                builder: (context, state) {
                                  if (state is GetOffersByTypeLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.primaryColor),
                                    );
                                  } else if (state is GetOffersByTypeLoaded) {
                                    return ListView.separated(
                                      itemCount: state.offers.length,
                                      itemBuilder: (context, index) {
                                        final offer = state.offers[index];
                                        return OffersContent(
                                          imageUrl: offer.image!,
                                          title: offer.title!,
                                          company: offer.company!,
                                          nature: offer.nature!,
                                          period: offer.periode!,
                                          units: offer.unit!,
                                          onFetchDetailOffer: () {
                                            Navigator.pushNamed(context,
                                                NavigationStrings.detailOffer,
                                                arguments: {
                                                  "offerId": offer.id,
                                                  "isFavorite": offer.isFavorite
                                                });
                                          },
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: 13.h,
                                          color: const Color(0xffe6ebef),
                                        );
                                      },
                                    );
                                  } else if (state is GetOffersByTypeFailure) {
                                    return Center(child: Text(state.message));
                                  }
                                  return Container();
                                },
                              ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
