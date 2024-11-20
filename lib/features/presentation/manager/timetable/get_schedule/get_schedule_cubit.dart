import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:school_test_online/features/domain/use_cases/timetable/fetch_schedules_use_case.dart';

import '../../../../domain/entities/timetable/schedule_entity.dart';

part 'get_schedule_state.dart';

class GetScheduleCubit extends Cubit<GetScheduleState> {
  final FetchScheduleUseCase fetchScheduleUseCase;
  String currentWeekKey;

  GetScheduleCubit({
    required this.fetchScheduleUseCase,
    required this.currentWeekKey,
  }) : super(GetScheduleInitial());

  Future<void> fetchSchedule(String weekKey) async {
    emit(GetScheduleLoading());
    try {
      final schedulesResult = await fetchScheduleUseCase.callback(weekKey);
      schedulesResult.fold(
        (failure) => emit(GetScheduleFailure(message: failure.message)),
        (schedules) => emit(GetScheduleLoaded(schedules: schedules)),
      );
      print("Result Get Schedule : $schedulesResult  $weekKey");
    } catch (e) {
      emit(GetScheduleFailure(message: e.toString()));
    }
  }

  Future<void> previousWeek() async {
    try {
      final previousWeekKey = _getPreviousWeekKey(currentWeekKey);
      currentWeekKey = previousWeekKey; // Update the current week key
      await fetchSchedule(previousWeekKey);
    } catch (e) {
      emit(GetScheduleFailure(
          message: 'Failed to load previous week: ${e.toString()}'));
    }
  }

  Future<void> nextWeek() async {
    try {
      final nextWeekKey = _getNextWeekKey(currentWeekKey);
      currentWeekKey = nextWeekKey; // Update the current week key
      await fetchSchedule(nextWeekKey);
    } catch (e) {
      emit(GetScheduleFailure(
          message: 'Failed to load next week: ${e.toString()}'));
    }
  }

  String _getPreviousWeekKey(String currentWeekKey) {
    final currentWeekDate = DateTime.parse(
        currentWeekKey); // Assuming weekKey is in DateTime format
    final previousWeekDate = currentWeekDate.subtract(const Duration(days: 7));
    return DateFormat('yyyy-MM-dd').format(
        previousWeekDate); // Adjust format to match your week key format
  }

  String _getNextWeekKey(String currentWeekKey) {
    final currentWeekDate = DateTime.parse(
        currentWeekKey); // Assuming weekKey is in DateTime format
    final nextWeekDate = currentWeekDate.add(const Duration(days: 7));
    return DateFormat('yyyy-MM-dd')
        .format(nextWeekDate); // Adjust format to match your week key format
  }
}
