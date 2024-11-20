import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';

import '../../../../domain/use_cases/courses/fetch_detail_course_use_case.dart';

part 'get_detail_course_state.dart';

class GetDetailCourseCubit extends Cubit<GetDetailCourseState> {
  final FetchDetailCourseUseCase fetchDetailCourseUseCase;
  GetDetailCourseCubit({required this.fetchDetailCourseUseCase})
      : super(GetDetailCourseInitial());

  Future<void> fetchDetailCourse(
      {required int courseId, required int formationId}) async {
    emit(GetDetailCourseLoading());
    try {
      final result =
          await fetchDetailCourseUseCase.callback(courseId, formationId);
      result.fold((l) => emit(GetDetailCourseFailure(message: l.message)),
          (r) => emit(GetDetailCourseLoaded(detailCourse: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDetailCourseFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDetailCourseFailure(message: e.toString()));
    }
  }
}
