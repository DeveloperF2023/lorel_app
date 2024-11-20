part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String? userToken;
  const Authenticated({this.userToken});

  @override
  List<Object> get props => [userToken!];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
