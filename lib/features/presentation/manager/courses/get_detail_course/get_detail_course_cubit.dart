import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';

import '../../../../domain/use_cases/courses/fetch_detail_course_use_case.dart';

part 'get_detail_course_state.dart';

class GetDetailCourseCubit extends Cubit<GetDetailCourseState> {
  final FetchDetailCourseUseCase fetchDetailCourseUseCase;
  final List<DetailCourseEntity> courses;
  int currentIndex = 0;
  GetDetailCourseCubit(
      {required this.fetchDetailCourseUseCase, required this.courses})
      : super(GetDetailCourseInitial());

  Future<void> fetchDetailCourse() async {
    emit(GetDetailCourseLoading());
    final currentCourse = courses[currentIndex];
    try {
      final result = await fetchDetailCourseUseCase.callback(
          currentCourse.id!, currentCourse.formationId!);
      result.fold(
          (l) => emit(GetDetailCourseFailure(message: l.message)),
          (r) => emit(GetDetailCourseLoaded(
                detailCourse: r,
                isLastCourse: currentIndex == courses.length - 1,
              )));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailCourseFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetDetailCourseFailure(message: e.toString()));
    }
  }

  void loadNextCourse() {
    if (currentIndex < courses.length - 1) {
      currentIndex++;
      fetchDetailCourse();
    }
  }
}
