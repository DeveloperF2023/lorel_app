part of 'apply_to_offer_cubit.dart';

sealed class ApplyToOfferState extends Equatable {
  const ApplyToOfferState();
}

final class ApplyToOfferInitial extends ApplyToOfferState {
  @override
  List<Object> get props => [];
}

final class ApplyToOfferLoading extends ApplyToOfferState {
  @override
  List<Object> get props => [];
}

final class ApplyToOfferLoaded extends ApplyToOfferState {
  final String message;

  ApplyToOfferLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

final class ApplyToOfferFailure extends ApplyToOfferState {
  final String message;

  const ApplyToOfferFailure({required this.message});
  @override
  List<Object> get props => [message];
}
