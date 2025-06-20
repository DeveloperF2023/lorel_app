import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/use_cases/offers/delete_from_favorite_list_use_case.dart';

part 'remove_from_favorite_list_state.dart';

class RemoveFromFavoriteListCubit extends Cubit<RemoveFromFavoriteListState> {
  final DeleteFromFavoriteListUseCase deleteFromFavoriteListUseCase;
  RemoveFromFavoriteListCubit({required this.deleteFromFavoriteListUseCase})
      : super(RemoveFromFavoriteListInitial());

  Future<void> deleteFromFavoriteList({required int offerId}) async {
    emit(RemoveFromFavoriteListLoading());
    try {
      final result = await deleteFromFavoriteListUseCase.callback(offerId);
      RemoveFromFavoriteListLoaded();
      debugPrint("Result Offers $result");
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(RemoveFromFavoriteListFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(RemoveFromFavoriteListFailure(message: e.toString()));
    }
  }
}
