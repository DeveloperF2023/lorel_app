part of 'get_courses_by_status_cubit.dart';

sealed class GetCoursesByStatusState extends Equatable {
  const GetCoursesByStatusState();
}

final class GetCoursesByStatusInitial extends GetCoursesByStatusState {
  @override
  List<Object> get props => [];
}

final class GetCoursesByStatusLoading extends GetCoursesByStatusState {
  @override
  List<Object> get props => [];
}

final class GetCoursesByStatusLoaded extends GetCoursesByStatusState {
  final List<CoursesByStatusEntity> coursesByStatus;

  const GetCoursesByStatusLoaded({required this.coursesByStatus});
  @override
  List<Object> get props => [coursesByStatus];
}

final class GetCoursesByStatusFailure extends GetCoursesByStatusState {
  final String message;

  GetCoursesByStatusFailure({required this.message});
  @override
  List<Object> get props => [message];
}
