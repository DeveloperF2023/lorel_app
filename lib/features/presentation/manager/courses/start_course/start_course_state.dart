part of 'start_course_cubit.dart';

sealed class StartCourseState extends Equatable {
  const StartCourseState();
}

final class StartCourseInitial extends StartCourseState {
  @override
  List<Object> get props => [];
}

final class StartCourseLoading extends StartCourseState {
  @override
  List<Object> get props => [];
}

final class StartCourseLoaded extends StartCourseState {
  final String message;

  const StartCourseLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

final class StartCourseFailure extends StartCourseState {
  final String message;

  const StartCourseFailure({required this.message});
  @override
  List<Object> get props => [message];
}
