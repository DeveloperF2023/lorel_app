part of 'get_rib_cubit.dart';

sealed class GetRibState extends Equatable {
  const GetRibState();
}

final class GetRibInitial extends GetRibState {
  @override
  List<Object> get props => [];
}

final class GetRibLoading extends GetRibState {
  @override
  List<Object> get props => [];
}

final class GetRibLoaded extends GetRibState {
  final RibEntity rib;

  GetRibLoaded({required this.rib});
  @override
  List<Object> get props => [];
}

final class GetRibFailure extends GetRibState {
  final String message;

  const GetRibFailure({required this.message});
  @override
  List<Object> get props => [message];
}
