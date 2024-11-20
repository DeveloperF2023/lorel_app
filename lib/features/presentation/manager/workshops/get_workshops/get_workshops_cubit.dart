import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';
import 'package:school_test_online/features/domain/use_cases/workshops/fetch_workshops_use_case.dart';

part 'get_workshops_state.dart';

class GetWorkshopsCubit extends Cubit<GetWorkshopsState> {
  final FetchWorkshopsUseCase fetchWorkshopsUseCase;
  GetWorkshopsCubit({required this.fetchWorkshopsUseCase})
      : super(GetWorkshopsInitial());
  Future<void> getWorkshops(DateTime selectedDate) async {
    emit(GetWorkshopsLoading());
    try {
      final result = await fetchWorkshopsUseCase.callback();
      result.fold((l) => emit(GetWorkshopsFailure(message: l.message)), (r) {
        // Filter workshops based on the selected date
        List<WorkshopEntity> filteredWorkshops = r.where((workshop) {
          // Check if the date_from matches the selected date
          return DateTime.parse(workshop.dateFrom!).year == selectedDate.year &&
              DateTime.parse(workshop.dateFrom!).month == selectedDate.month &&
              DateTime.parse(workshop.dateFrom!).day == selectedDate.day;
        }).toList();

        emit(GetWorkshopsLoaded(workshops: filteredWorkshops));
      });
    } on SocketException catch (e) {
      emit(GetWorkshopsFailure(message: e.toString()));
    } catch (e) {
      emit(GetWorkshopsFailure(message: e.toString()));
    }
  }
}
