import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/offers/offers_entity.dart';

import '../../../../domain/use_cases/offers/search_offers_use_case.dart';

part 'search_offers_state.dart';

class SearchOffersCubit extends Cubit<SearchOffersState> {
  final SearchOffersUseCase searchOffersUseCase;
  SearchOffersCubit({required this.searchOffersUseCase})
      : super(SearchOffersInitial());

  Future<void> searchOffer({required String query}) async {
    emit(SearchOffersLoading());

    try {
      final result = await searchOffersUseCase.callback(query);

      result.fold(
        (failure) {
          emit(SearchOffersFailure(message: failure.message));
        },
        (successMessage) {
          emit(SearchOffersLoaded(searchOffers: successMessage));
        },
      );
    } on SocketException {
      // Handle network errors
      emit(const SearchOffersFailure(
          message: "No internet connection. Please try again."));
    } catch (e) {
      // Handle general errors
      emit(const SearchOffersFailure(message: "An error occurred while applying."));
    }
  }

  void clearSearch() {
    emit(SearchOffersInitial()); // Reset to initial state
  }
}
