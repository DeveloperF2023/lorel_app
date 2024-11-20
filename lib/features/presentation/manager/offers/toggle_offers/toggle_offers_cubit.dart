import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_offers_state.dart';

class ToggleOffersCubit extends Cubit<ToggleOffersState> {
  ToggleOffersCubit() : super(ToggleOffersState.initial());

  void toggleButton(int index) {
    final updatedSelection = List<bool>.from(state.isSelected);
    for (int i = 0; i < updatedSelection.length; i++) {
      updatedSelection[i] = i == index;
    }
    emit(ToggleOffersState(isSelected: updatedSelection));
  }
}
