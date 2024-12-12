import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/use_cases/user/update_password_use_case.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final UpdatePasswordUserUseCase updatePasswordUserUseCase;
  UpdatePasswordCubit({required this.updatePasswordUserUseCase})
      : super(UpdatePasswordInitial());

  Future<void> updatePasswordUser(
      {required String oldPassword,
      required String password,
      required String confirmationPassword}) async {
    emit(UpdatePasswordLoading());
    try {
      await updatePasswordUserUseCase.callback(
          oldPassword, password, confirmationPassword);
      emit(UpdatePasswordLoaded(message: "Password Updated Successfully"));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      emit(UpdatePasswordFailure(message: e.message));
    } catch (e) {
      debugPrint("this is error $e");
      emit(UpdatePasswordFailure(message: e.toString()));
    }
  }
}
