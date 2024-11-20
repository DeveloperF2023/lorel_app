part of 'search_offers_cubit.dart';

sealed class SearchOffersState extends Equatable {
  const SearchOffersState();
}

final class SearchOffersInitial extends SearchOffersState {
  @override
  List<Object> get props => [];
}

final class SearchOffersLoading extends SearchOffersState {
  @override
  List<Object> get props => [];
}

final class SearchOffersLoaded extends SearchOffersState {
  final List<OffersEntity> searchOffers;

  SearchOffersLoaded({required this.searchOffers});
  @override
  List<Object> get props => [searchOffers];
}

final class SearchOffersFailure extends SearchOffersState {
  final String message;

  SearchOffersFailure({required this.message});
  @override
  List<Object> get props => [message];
}
