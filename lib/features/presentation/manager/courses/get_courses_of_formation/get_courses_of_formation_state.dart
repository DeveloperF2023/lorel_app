part of 'get_courses_of_formation_cubit.dart';

sealed class GetCoursesOfFormationState extends Equatable {
  const GetCoursesOfFormationState();
}

final class GetCoursesOfFormationInitial extends GetCoursesOfFormationState {
  @override
  List<Object> get props => [];
}

final class GetCoursesOfFormationLoading extends GetCoursesOfFormationState {
  @override
  List<Object> get props => [];
}

final class GetCoursesOfFormationLoaded extends GetCoursesOfFormationState {
  final List<DetailCourseEntity> courses;

  const GetCoursesOfFormationLoaded({required this.courses});
  @override
  List<Object> get props => [courses];
}

final class GetCoursesOfFormationFailure extends GetCoursesOfFormationState {
  final String message;

  const GetCoursesOfFormationFailure({required this.message});
  @override
  List<Object> get props => [message];
}
