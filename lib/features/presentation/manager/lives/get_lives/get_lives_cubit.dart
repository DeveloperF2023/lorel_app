import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/lives/lives_entity.dart';
import 'package:school_test_online/features/domain/use_cases/lives/fetch_lives_use_case.dart';

part 'get_lives_state.dart';

class GetLivesCubit extends Cubit<GetLivesState> {
  final FetchLivesUseCase fetchLivesUseCase;
  GetLivesCubit({required this.fetchLivesUseCase}) : super(GetLivesInitial());
  Future<void> getLives() async {
    emit(GetLivesLoading());
    try {
      final result = await fetchLivesUseCase.callback();
      result.fold((l) => emit(GetLivesFailure(message: l.message)),
          (r) => emit(GetLivesLoaded(lives: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetLivesFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetLivesFailure(message: e.toString()));
    }
  }
}
