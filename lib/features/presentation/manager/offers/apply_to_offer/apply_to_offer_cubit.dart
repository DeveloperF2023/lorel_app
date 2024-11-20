import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/use_cases/offers/apply_to_offer_use_case.dart';

part 'apply_to_offer_state.dart';

class ApplyToOfferCubit extends Cubit<ApplyToOfferState> {
  final ApplyToOfferUseCase applyToOfferUseCase;
  ApplyToOfferCubit({required this.applyToOfferUseCase})
      : super(ApplyToOfferInitial());
  Future<void> applyToOffer(
      {required int offerId, required File resume}) async {
    emit(ApplyToOfferLoading());

    try {
      // Call the use case
      final result = await applyToOfferUseCase.callback(offerId, resume);

      // Handle result from the use case
      result.fold(
        (failure) {
          // Emit the error message (such as the 403 error)
          emit(ApplyToOfferFailure(message: failure.message));
        },
        (successMessage) {
          emit(ApplyToOfferLoaded(message: successMessage));
        },
      );
    } on SocketException catch (e) {
      // Handle network errors
      emit(const ApplyToOfferFailure(
          message: "No internet connection. Please try again."));
    } catch (e) {
      // Handle general errors
      emit(const ApplyToOfferFailure(
          message: "An error occurred while applying."));
    }
  }
}
