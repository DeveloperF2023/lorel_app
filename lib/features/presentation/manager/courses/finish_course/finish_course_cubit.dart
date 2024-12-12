import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/use_cases/courses/finish_course_use_case.dart';

part 'finish_course_state.dart';

class FinishCourseCubit extends Cubit<FinishCourseState> {
  final FinishCourseUseCase finishCourseUseCase;
  FinishCourseCubit({required this.finishCourseUseCase})
      : super(FinishCourseInitial());

  Future<void> finishCourse(
      {required int courseId, required int formationId}) async {
    emit(FinishCourseLoading());
    try {
      final result = await finishCourseUseCase.callback(courseId, formationId);
      result.fold((l) => emit(FinishCourseFailure(message: l.message)),
          (r) => emit(FinishCourseLoaded(message: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed finish course");
      emit(FinishCourseFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed finish course");
      emit(FinishCourseFailure(message: e.toString()));
    }
  }
}
