part of 'get_courses_by_domain_cubit.dart';

sealed class GetCoursesByDomainState extends Equatable {
  const GetCoursesByDomainState();
}

final class GetCoursesByDomainInitial extends GetCoursesByDomainState {
  @override
  List<Object> get props => [];
}

final class GetCoursesByDomainLoading extends GetCoursesByDomainState {
  @override
  List<Object> get props => [];
}

final class GetCoursesByDomainLoaded extends GetCoursesByDomainState {
  final List<CoursesEntity> courses;

  const GetCoursesByDomainLoaded({required this.courses});
  @override
  List<Object> get props => [courses];
}

final class GetCoursesByDomainFailure extends GetCoursesByDomainState {
  final String message;

  const GetCoursesByDomainFailure({required this.message});
  @override
  List<Object> get props => [message];
}
