part of 'upload_avatar_cubit.dart';

sealed class UploadAvatarState extends Equatable {
  const UploadAvatarState();
}

final class UploadAvatarInitial extends UploadAvatarState {
  @override
  List<Object> get props => [];
}

final class UploadAvatarLoading extends UploadAvatarState {
  @override
  List<Object> get props => [];
}

final class UploadAvatarLoaded extends UploadAvatarState {
  final String uploadAvatar;

  const UploadAvatarLoaded({required this.uploadAvatar});
  @override
  List<Object> get props => [uploadAvatar];
}

final class UploadAvatarFailure extends UploadAvatarState {
  final String message;

  const UploadAvatarFailure({required this.message});
  @override
  List<Object> get props => [message];
}
