part of 'get_offers_by_type_cubit.dart';

sealed class GetOffersByTypeState extends Equatable {
  const GetOffersByTypeState();
}

final class GetOffersByTypeInitial extends GetOffersByTypeState {
  @override
  List<Object> get props => [];
}

final class GetOffersByTypeLoading extends GetOffersByTypeState {
  @override
  List<Object> get props => [];
}

final class GetOffersByTypeLoaded extends GetOffersByTypeState {
  final List<OffersEntity> offers;

  const GetOffersByTypeLoaded({required this.offers});
  @override
  List<Object> get props => [offers];
}

final class GetOffersByTypeFailure extends GetOffersByTypeState {
  final String message;

  GetOffersByTypeFailure({required this.message});
  @override
  List<Object> get props => [message];
}
