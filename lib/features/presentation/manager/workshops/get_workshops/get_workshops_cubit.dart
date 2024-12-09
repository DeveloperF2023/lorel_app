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

      result.fold(
        (failure) => emit(GetWorkshopsFailure(message: failure.message)),
        (workshops) {
          List<WorkshopEntity> filteredWorkshops = workshops.where((workshop) {
            DateTime createdAt = DateTime.parse(workshop.createdAt!);
            DateTime dateFrom = DateTime.parse(workshop.dateFrom!);

            return selectedDate
                    .isAfter(createdAt.subtract(const Duration(days: 1))) &&
                selectedDate.isBefore(dateFrom.add(const Duration(days: 1)));
          }).toList();

          emit(GetWorkshopsLoaded(workshops: filteredWorkshops));
        },
      );
    } on SocketException catch (e) {
      emit(GetWorkshopsFailure(message: e.toString()));
    } catch (e) {
      emit(GetWorkshopsFailure(message: e.toString()));
    }
  }
}
