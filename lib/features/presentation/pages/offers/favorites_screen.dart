import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_test_online/core/utils/helpers/locale_service.dart';
import 'package:school_test_online/dependencies_injection.dart';
import 'package:school_test_online/features/presentation/manager/offers/get_favorites/get_favorites_cubit.dart';
import 'package:school_test_online/features/presentation/widgets/all_courses/widgets_imports.dart';

import '../../../../core/routes/routes.dart';
import '../../manager/offers/add_to_favorite_list/add_to_favorite_list_cubit.dart';
import '../../manager/offers/favorite_status_cubit.dart';
import '../../manager/offers/remove_from_favorite_list/remove_from_favorite_list_cubit.dart';
import '../../widgets/offers/widgets_imports.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAllCourses(
        title: AppLocalization.of(context)!.translate("favorites"),
        onTap: () =>
            Navigator.pushReplacementNamed(context, NavigationStrings.offers),
      ),
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<GetFavoritesCubit>()..getFavorites(),
          ),
          BlocProvider(
            create: (context) => locator<AddToFavoriteListCubit>(),
          ),
          BlocProvider(
            create: (context) => locator<RemoveFromFavoriteListCubit>(),
          ),
        ],
        child: BlocBuilder<GetFavoritesCubit, GetFavoritesState>(
          builder: (context, state) {
            if (state is GetFavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetFavoritesLoaded) {
              return ListView.separated(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = state.favorites[index];
                  final isFavorite = favorite.isFavorite;
                  return BlocProvider<FavoriteStatusCubit>(
                    create: (context) => FavoriteStatusCubit(isFavorite!),
                    child: FavoriteContent(
                      imageUrl: favorite.image!,
                      title: favorite.title!,
                      company: favorite.company!,
                      nature: favorite.nature!,
                      period: favorite.periode!,
                      units: favorite.unit!,
                      offerId: favorite.pivot != null
                          ? favorite.pivot!.offerId!
                          : favorite.id!,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 2.h,
                    color: const Color(0xffe6ebef),
                  );
                },
              );
            } else if (state is GetFavoritesFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      )),
    );
  }
}
