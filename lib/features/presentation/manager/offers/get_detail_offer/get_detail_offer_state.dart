part of 'get_detail_offer_cubit.dart';

sealed class GetDetailOfferState extends Equatable {
  const GetDetailOfferState();
}

final class GetDetailOfferInitial extends GetDetailOfferState {
  @override
  List<Object> get props => [];
}

final class GetDetailOfferLoading extends GetDetailOfferState {
  @override
  List<Object> get props => [];
}

final class GetDetailOfferLoaded extends GetDetailOfferState {
  final DetailOfferEntity offer;

  const GetDetailOfferLoaded({required this.offer});
  @override
  List<Object> get props => [offer];
}

final class GetDetailOfferFailure extends GetDetailOfferState {
  final String message;

  GetDetailOfferFailure({required this.message});
  @override
  List<Object> get props => [message];
}
