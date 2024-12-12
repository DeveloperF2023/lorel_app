import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_buttons_state.dart';

class ToggleButtonsCubit extends Cubit<ToggleButtonsState> {
  ToggleButtonsCubit()
      : super(const ToggleButtonsState(
            isSelected: [true, false], status: 'in_progress'));

  void toggleButton(int index) {
    final isSelected = List<bool>.from(state.isSelected);
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    final status = index == 0 ? 'in_progress' : 'finished';
    emit(ToggleButtonsState(isSelected: isSelected, status: status));
  }
}
