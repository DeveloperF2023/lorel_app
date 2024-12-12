import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

import '../../../../domain/use_cases/courses/fetch_detail_formation_use_case.dart';

part 'get_detail_formation_state.dart';

class GetDetailFormationCubit extends Cubit<GetDetailFormationState> {
  final FetchDetailFormationUseCase fetchDetailFormationUseCase;
  GetDetailFormationCubit({required this.fetchDetailFormationUseCase})
      : super(GetDetailFormationInitial());
  Future<void> fetchFormations(
      {required int domainId, required int formationId}) async {
    emit(GetDetailFormationLoading());
    try {
      final result =
          await fetchDetailFormationUseCase.callback(domainId, formationId);
      result.fold((l) => emit(GetDetailFormationFailure(message: l.message)),
          (r) => emit(GetDetailFormationLoaded(detailFormation: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailFormationFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailFormationFailure(message: e.toString()));
    }
  }
}
