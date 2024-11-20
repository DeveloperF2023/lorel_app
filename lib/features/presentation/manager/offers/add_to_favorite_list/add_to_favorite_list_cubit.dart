import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/use_cases/offers/add_to_favorite_list_use_case.dart';

part 'add_to_favorite_list_state.dart';

class AddToFavoriteListCubit extends Cubit<AddToFavoriteListState> {
  final AddToFavoriteListUseCase addToFavoriteListUseCase;
  AddToFavoriteListCubit({required this.addToFavoriteListUseCase})
      : super(AddToFavoriteListInitial());
  Future<void> addToFavoriteList({required int offerId}) async {
    emit(AddToFavoriteListLoading());
    try {
      final result = await addToFavoriteListUseCase.callback(offerId);
      AddToFavoriteListLoaded();
      print("Result Offers $result");
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(AddToFavoriteListFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(AddToFavoriteListFailure(message: e.toString()));
    }
  }
}
