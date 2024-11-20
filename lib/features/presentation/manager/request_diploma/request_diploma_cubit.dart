import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/use_cases/request_diploma/request_diploma_use_case.dart';

import '../../../data/models/request_diploma/request_diploma_model.dart';

part 'request_diploma_state.dart';

class RequestDiplomaCubit extends Cubit<RequestDiplomaState> {
  final RequestDiplomaUseCase requestDiplomaUseCase;
  RequestDiplomaCubit({required this.requestDiplomaUseCase})
      : super(RequestDiplomaInitial());
  Future<void> requestDiploma(
      {required RequestDiplomaModel requests, required int formationId}) async {
    emit(RequestDiplomaLoading());
    try {
      await requestDiplomaUseCase.callback(requests, formationId);
      emit(RequestDiplomaLoaded());
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(RequestDiplomaFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(RequestDiplomaFailure(message: e.toString()));
    }
  }
}
