part of 'update_profile_cubit.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

final class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

final class UpdateProfileLoading extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

final class UpdateProfileLoaded extends UpdateProfileState {
  final UpdateUserEntity updateUserProfile;

  UpdateProfileLoaded({required this.updateUserProfile});
  @override
  List<Object> get props => [updateUserProfile];
}

final class UpdateProfileFailure extends UpdateProfileState {
  final String message;

  UpdateProfileFailure({required this.message});
  @override
  List<Object> get props => [message];
}
