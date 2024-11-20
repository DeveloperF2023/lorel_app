part of 'get_schedule_cubit.dart';

sealed class GetScheduleState extends Equatable {
  const GetScheduleState();
}

final class GetScheduleInitial extends GetScheduleState {
  @override
  List<Object> get props => [];
}

final class GetScheduleLoading extends GetScheduleState {
  @override
  List<Object> get props => [];
}

final class GetScheduleLoaded extends GetScheduleState {
  final Map<String, List<ScheduleEntity>> schedules;

  GetScheduleLoaded({required this.schedules});
  @override
  List<Object> get props => [schedules];
}

final class GetScheduleFailure extends GetScheduleState {
  final String message;

  const GetScheduleFailure({required this.message});
  @override
  List<Object> get props => [message];
}
