import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';
import 'package:school_test_online/features/domain/use_cases/workshops/fetch_workshop_by_id_use_case.dart';

part 'get_detail_workshop_state.dart';

class GetDetailWorkshopCubit extends Cubit<GetDetailWorkshopState> {
  final FetchWorkshopsByIdUseCase fetchWorkshopsByIdUseCase;
  GetDetailWorkshopCubit({required this.fetchWorkshopsByIdUseCase})
      : super(GetDetailWorkshopInitial());
  Future<void> getWorkshopsById({required int workshopId}) async {
    emit(GetDetailWorkshopLoading());
    try {
      final result = await fetchWorkshopsByIdUseCase.callback(workshopId);
      result.fold((l) => emit(GetDetailWorkshopFailure(message: l.message)),
          (r) => emit(GetDetailWorkshopLoaded(workshop: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDetailWorkshopFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDetailWorkshopFailure(message: e.toString()));
    }
  }
}
