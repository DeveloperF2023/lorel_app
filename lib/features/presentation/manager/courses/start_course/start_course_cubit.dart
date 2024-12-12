import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/use_cases/courses/start_course_use_case.dart';

part 'start_course_state.dart';

class StartCourseCubit extends Cubit<StartCourseState> {
  final StartCourseUseCase startCourseUseCase;
  StartCourseCubit({required this.startCourseUseCase})
      : super(StartCourseInitial());

  Future<void> startCourse(
      {required int courseId, required int formationId}) async {
    emit(StartCourseLoading());
    try {
      final result = await startCourseUseCase.callback(courseId, formationId);
      result.fold((l) => emit(StartCourseFailure(message: l.message)),
          (r) => emit(StartCourseLoaded(message: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed start course");
      emit(StartCourseFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed start course");
      emit(StartCourseFailure(message: e.toString()));
    }
  }
}
