import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/use_cases/user/get_current_customer_token_use_case.dart';
import '../../../../domain/use_cases/user/is_sign_in_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentTokenUserUseCase getCurrentTokenUserUseCase;
  final IsSignInUserUseCase isSignInUserUseCase;
  AuthCubit({
    required this.getCurrentTokenUserUseCase,
    required this.isSignInUserUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUserUseCase.callback();
      if (isSignIn) {
        final token = await getCurrentTokenUserUseCase.callback();
        debugPrint("Fetched token: $token");
        if (isValidToken(token)) {
          debugPrint("Valid token: $token");
          emit(Authenticated(userToken: token));
        } else {
          debugPrint("Invalid token: $token");
          emit(UnAuthenticated());
        }
      } else {
        debugPrint("User is not signed in");
        emit(UnAuthenticated());
      }
    } catch (e) {
      debugPrint("Error during authentication: $e");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final token = await getCurrentTokenUserUseCase.callback();
      debugPrint("this is token $token");
      emit(Authenticated(userToken: token));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  bool isValidToken(String token) {
    // Implement token validation logic here
    // Example: Check token expiration, format, etc.
    return true; // Replace with actual validation
  }
}
