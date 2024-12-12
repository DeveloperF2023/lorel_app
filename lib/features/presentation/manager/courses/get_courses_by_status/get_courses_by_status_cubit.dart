import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/courses/courses_by_status_entity.dart';
import '../../../../domain/use_cases/courses/fetch_courses_by_status_use_case.dart';

part 'get_courses_by_status_state.dart';

class GetCoursesByStatusCubit extends Cubit<GetCoursesByStatusState> {
  final FetchCoursesByStatusUseCase fetchCoursesByStatusUseCase;
  GetCoursesByStatusCubit({required this.fetchCoursesByStatusUseCase})
      : super(GetCoursesByStatusInitial());
  Future<void> fetchCoursesByStatus({required String status}) async {
    emit(GetCoursesByStatusLoading());
    try {
      final result = await fetchCoursesByStatusUseCase.callback(status);
      result.fold((l) => emit(GetCoursesByStatusFailure(message: l.message)),
          (r) => emit(GetCoursesByStatusLoaded(coursesByStatus: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetCoursesByStatusFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetCoursesByStatusFailure(message: e.toString()));
    }
  }
}
