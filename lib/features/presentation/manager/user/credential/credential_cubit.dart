import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/error/failure.dart';
import '../../../../domain/use_cases/user/login_user_use_case.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final LoginUserUseCase loginUserUseCase;
  CredentialCubit({required this.loginUserUseCase})
      : super(CredentialInitial());

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      final eitherFailureOrSuccess =
          await loginUserUseCase.callback(email, password);

      eitherFailureOrSuccess.fold(
        (failure) {
          emit(CredentialFailure(message: _mapFailureToMessage(failure)));
        },
        (user) {
          if (user.token == null) {
            emit(CredentialFailure(message: "User data is missing."));
          } else {
            emit(CredentialSuccess());
          }
        },
      );
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      emit(CredentialFailure(message: "Network error: ${e.message}"));
    } catch (e) {
      debugPrint("General error: $e");
      emit(CredentialFailure(message: "Login error: ${e.toString()}"));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return "Server error. Please try again later.";
      case DatabaseFailure _:
        return "Cache error. Please check your local storage.";
      default:
        return "Unexpected error. Please try again.";
    }
  }

  void resetState() {
    emit(CredentialInitial());
  }
}
