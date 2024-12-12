part of 'toggle_offers_cubit.dart';

class ToggleOffersState extends Equatable {
  final List<bool> isSelected;

  ToggleOffersState({required this.isSelected});

  factory ToggleOffersState.initial() {
    return ToggleOffersState(
        isSelected: const [true, false]); // Default selection
  }

  ToggleOffersState copyWith({List<bool>? isSelected}) {
    return ToggleOffersState(
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [isSelected];
}
