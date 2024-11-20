part of 'register_user_cubit.dart';

sealed class RegisterUserState extends Equatable {
  const RegisterUserState();
}

final class RegisterUserInitial extends RegisterUserState {
  @override
  List<Object> get props => [];
}

final class RegisterUserLoading extends RegisterUserState {
  @override
  List<Object> get props => [];
}

final class RegisterUserLoaded extends RegisterUserState {
  @override
  List<Object> get props => [];
}

final class RegisterUserFailure extends RegisterUserState {
  final String message;

  const RegisterUserFailure({required this.message});
  @override
  List<Object> get props => [message];
}
