import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/offers/offers_entity.dart';
import 'package:school_test_online/features/domain/use_cases/offers/fetch_offers_by_type_use_case.dart';

part 'get_offers_by_type_state.dart';

class GetOffersByTypeCubit extends Cubit<GetOffersByTypeState> {
  final FetchOffersByTypeUseCase fetchOffersByTypeUseCase;
  GetOffersByTypeCubit({required this.fetchOffersByTypeUseCase})
      : super(GetOffersByTypeInitial());

  Future<void> getOffersByType({required String type}) async {
    emit(GetOffersByTypeLoading());
    try {
      final result = await fetchOffersByTypeUseCase.callback(type);
      result.fold((l) => emit(GetOffersByTypeFailure(message: l.message)),
          (r) => emit(GetOffersByTypeLoaded(offers: r)));
      print("Result Offers $result");
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetOffersByTypeFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetOffersByTypeFailure(message: e.toString()));
    }
  }
}
