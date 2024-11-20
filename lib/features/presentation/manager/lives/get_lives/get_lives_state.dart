part of 'get_lives_cubit.dart';

sealed class GetLivesState extends Equatable {
  const GetLivesState();
}

final class GetLivesInitial extends GetLivesState {
  @override
  List<Object> get props => [];
}

final class GetLivesLoading extends GetLivesState {
  @override
  List<Object> get props => [];
}

final class GetLivesLoaded extends GetLivesState {
  final List<LivesEntity> lives;

  GetLivesLoaded({required this.lives});
  @override
  List<Object> get props => [lives];
}

final class GetLivesFailure extends GetLivesState {
  final String message;

  const GetLivesFailure({required this.message});
  @override
  List<Object> get props => [message];
}
