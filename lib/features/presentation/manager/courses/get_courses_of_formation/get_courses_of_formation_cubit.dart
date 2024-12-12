import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';
import 'package:school_test_online/features/domain/use_cases/courses/fetch_course_of_formation_use_case.dart';

part 'get_courses_of_formation_state.dart';

class GetCoursesOfFormationCubit extends Cubit<GetCoursesOfFormationState> {
  final FetchCoursesOfFormationUseCase fetchCoursesOfFormationUseCase;
  GetCoursesOfFormationCubit({required this.fetchCoursesOfFormationUseCase})
      : super(GetCoursesOfFormationInitial());

  Future<void> fetchCoursesOfFormation({required int formationId}) async {
    emit(GetCoursesOfFormationLoading());
    try {
      final result = await fetchCoursesOfFormationUseCase.callback(formationId);
      debugPrint("Result from cubit $result");
      result.fold((l) => emit(GetCoursesOfFormationFailure(message: l.message)),
          (r) => emit(GetCoursesOfFormationLoaded(courses: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed fetch formation");
      emit(GetCoursesOfFormationFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed fetch formation");
      emit(GetCoursesOfFormationFailure(message: e.toString()));
    }
  }
}
