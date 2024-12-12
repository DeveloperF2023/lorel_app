import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/courses/courses_entity.dart';
import '../../../../domain/use_cases/domain/fetch_courses_by_domains_use_case.dart';

part 'get_courses_by_domain_state.dart';

class GetCoursesByDomainCubit extends Cubit<GetCoursesByDomainState> {
  final FetchCoursesByDomainUseCase fetchCoursesByDomainUseCase;
  GetCoursesByDomainCubit({required this.fetchCoursesByDomainUseCase})
      : super(GetCoursesByDomainInitial());
  Future<void> fetchCourses({required int domainId}) async {
    emit(GetCoursesByDomainLoading());
    try {
      final result = await fetchCoursesByDomainUseCase.callback(domainId);
      result.fold((l) => emit(GetCoursesByDomainFailure(message: l.message)),
          (r) => emit(GetCoursesByDomainLoaded(courses: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetCoursesByDomainFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetCoursesByDomainFailure(message: e.toString()));
    }
  }
}
