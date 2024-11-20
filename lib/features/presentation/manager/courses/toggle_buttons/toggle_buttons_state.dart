part of 'toggle_buttons_cubit.dart';

class ToggleButtonsState extends Equatable {
  final List<bool> isSelected;
  final String status;
  const ToggleButtonsState({required this.isSelected, required this.status});

  @override
  List<Object?> get props => [isSelected, status];
}
