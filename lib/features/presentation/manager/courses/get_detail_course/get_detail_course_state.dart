part of 'get_detail_course_cubit.dart';

sealed class GetDetailCourseState extends Equatable {
  const GetDetailCourseState();
}

final class GetDetailCourseInitial extends GetDetailCourseState {
  @override
  List<Object> get props => [];
}

final class GetDetailCourseLoading extends GetDetailCourseState {
  @override
  List<Object> get props => [];
}

final class GetDetailCourseLoaded extends GetDetailCourseState {
  final DetailCourseEntity detailCourse;
  final bool isLastCourse;

  const GetDetailCourseLoaded(
      {required this.detailCourse, required this.isLastCourse});
  @override
  List<Object> get props => [];
}

final class GetDetailCourseFailure extends GetDetailCourseState {
  final String message;

  const GetDetailCourseFailure({required this.message});
  @override
  List<Object> get props => [message];
}
