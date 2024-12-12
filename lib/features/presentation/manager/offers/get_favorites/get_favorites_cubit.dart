import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/offers/favorite_entity.dart';
import 'package:school_test_online/features/domain/use_cases/offers/fetch_favorites_use_case.dart';

part 'get_favorites_state.dart';

class GetFavoritesCubit extends Cubit<GetFavoritesState> {
  final FetchFavoritesByTypeUseCase favoritesByTypeUseCase;
  GetFavoritesCubit({required this.favoritesByTypeUseCase})
      : super(GetFavoritesInitial());
  Future<void> getFavorites() async {
    emit(GetFavoritesLoading());
    try {
      final result = await favoritesByTypeUseCase.callback();
      result.fold((l) => emit(GetFavoritesFailure(message: l.message)),
          (r) => emit(GetFavoritesLoaded(favorites: r)));
      debugPrint("Result Offers $result");
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetFavoritesFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetFavoritesFailure(message: e.toString()));
    }
  }
}
