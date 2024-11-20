part of 'get_detail_formation_cubit.dart';

sealed class GetDetailFormationState extends Equatable {
  const GetDetailFormationState();
}

final class GetDetailFormationInitial extends GetDetailFormationState {
  @override
  List<Object> get props => [];
}

final class GetDetailFormationLoading extends GetDetailFormationState {
  @override
  List<Object> get props => [];
}

final class GetDetailFormationLoaded extends GetDetailFormationState {
  final CoursesEntity detailFormation;

  const GetDetailFormationLoaded({required this.detailFormation});
  @override
  List<Object> get props => [detailFormation];
}

final class GetDetailFormationFailure extends GetDetailFormationState {
  final String message;

  const GetDetailFormationFailure({required this.message});
  @override
  List<Object> get props => [message];
}
