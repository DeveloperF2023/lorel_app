import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/user/request_register_user_entity.dart';
import '../../../../domain/use_cases/user/register_user_use_case.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final RegisterUserUseCase registerUserUseCase;
  RegisterUserCubit({required this.registerUserUseCase})
      : super(RegisterUserInitial());

  Future<void> signUpUser({required RequestRegisterUserEntity requests}) async {
    emit(RegisterUserLoading());
    try {
      final result = await registerUserUseCase.callback(requests);
      result.fold((l) {
        debugPrint("ERROR: ${l.message}");
        emit(RegisterUserFailure(message: l.message));
      }, (r) {
        emit(RegisterUserLoaded());
      });
    } on SocketException catch (e) {
      debugPrint("This is error $e");
      emit(RegisterUserFailure(message: e.message));
    } catch (e) {
      debugPrint("This is error $e");
      emit(RegisterUserFailure(message: e.toString()));
    }
  }
}
