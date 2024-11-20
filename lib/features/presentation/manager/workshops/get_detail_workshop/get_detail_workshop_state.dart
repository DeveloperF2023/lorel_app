part of 'get_detail_workshop_cubit.dart';

sealed class GetDetailWorkshopState extends Equatable {
  const GetDetailWorkshopState();
}

final class GetDetailWorkshopInitial extends GetDetailWorkshopState {
  @override
  List<Object> get props => [];
}

final class GetDetailWorkshopLoading extends GetDetailWorkshopState {
  @override
  List<Object> get props => [];
}

final class GetDetailWorkshopLoaded extends GetDetailWorkshopState {
  final WorkshopEntity workshop;

  GetDetailWorkshopLoaded({required this.workshop});
  @override
  List<Object> get props => [workshop];
}

final class GetDetailWorkshopFailure extends GetDetailWorkshopState {
  final String message;

  GetDetailWorkshopFailure({required this.message});
  @override
  List<Object> get props => [message];
}
