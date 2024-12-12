import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/payment/rib_entity.dart';

import '../../../../domain/use_cases/payment/get_rib_use_case.dart';

part 'get_rib_state.dart';

class GetRibCubit extends Cubit<GetRibState> {
  final FetchRibUseCase fetchRibUseCase;
  GetRibCubit({required this.fetchRibUseCase}) : super(GetRibInitial());

  Future<void> getRib() async {
    emit(GetRibLoading());
    try {
      final result = await fetchRibUseCase.callback();
      result.fold((l) => emit(GetRibFailure(message: l.message)),
          (r) => emit(GetRibLoaded(rib: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetRibFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetRibFailure(message: e.toString()));
    }
  }
}
