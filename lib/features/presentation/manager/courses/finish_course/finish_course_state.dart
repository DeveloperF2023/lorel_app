part of 'finish_course_cubit.dart';

sealed class FinishCourseState extends Equatable {
  const FinishCourseState();
}

final class FinishCourseInitial extends FinishCourseState {
  @override
  List<Object> get props => [];
}

final class FinishCourseLoading extends FinishCourseState {
  @override
  List<Object> get props => [];
}

final class FinishCourseLoaded extends FinishCourseState {
  final String message;

  const FinishCourseLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

final class FinishCourseFailure extends FinishCourseState {
  final String message;

  const FinishCourseFailure({required this.message});
  @override
  List<Object> get props => [message];
}
