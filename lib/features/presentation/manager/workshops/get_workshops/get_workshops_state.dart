part of 'get_workshops_cubit.dart';

sealed class GetWorkshopsState extends Equatable {
  const GetWorkshopsState();
}

final class GetWorkshopsInitial extends GetWorkshopsState {
  @override
  List<Object> get props => [];
}

final class GetWorkshopsLoading extends GetWorkshopsState {
  @override
  List<Object> get props => [];
}

final class GetWorkshopsLoaded extends GetWorkshopsState {
  final List<WorkshopEntity> workshops;

  const GetWorkshopsLoaded({required this.workshops});
  @override
  List<Object> get props => [workshops];
}

final class GetWorkshopsFailure extends GetWorkshopsState {
  final String message;

  const GetWorkshopsFailure({required this.message});
  @override
  List<Object> get props => [message];
}
