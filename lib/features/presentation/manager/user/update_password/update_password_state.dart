part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();
}

final class UpdatePasswordInitial extends UpdatePasswordState {
  @override
  List<Object> get props => [];
}

final class UpdatePasswordLoading extends UpdatePasswordState {
  @override
  List<Object> get props => [];
}

final class UpdatePasswordLoaded extends UpdatePasswordState {
  final String message;

  UpdatePasswordLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

final class UpdatePasswordFailure extends UpdatePasswordState {
  final String message;

  UpdatePasswordFailure({required this.message});
  @override
  List<Object> get props => [message];
}
