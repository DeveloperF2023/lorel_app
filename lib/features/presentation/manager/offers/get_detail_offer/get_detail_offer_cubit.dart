import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/offers/detail_offer_entity.dart';
import 'package:school_test_online/features/domain/use_cases/offers/fetch_detail_offer_use_case.dart';

part 'get_detail_offer_state.dart';

class GetDetailOfferCubit extends Cubit<GetDetailOfferState> {
  final FetchDetailOffersUseCase fetchDetailOffersUseCase;
  GetDetailOfferCubit({required this.fetchDetailOffersUseCase})
      : super(GetDetailOfferInitial());

  Future<void> getDetailOffer({required int offerId}) async {
    emit(GetDetailOfferLoading());
    try {
      final result = await fetchDetailOffersUseCase.callback(offerId);
      result.fold((l) => emit(GetDetailOfferFailure(message: l.message)),
          (r) => emit(GetDetailOfferLoaded(offer: r)));
      debugPrint("Result Offers $result");
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailOfferFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailOfferFailure(message: e.toString()));
    }
  }
}
