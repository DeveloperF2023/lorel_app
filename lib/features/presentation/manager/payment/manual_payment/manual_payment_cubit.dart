import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/payment/manual_payment_response_entity.dart';
import 'package:school_test_online/features/domain/use_cases/payment/manual_payment_use_case.dart';

part 'manual_payment_state.dart';

class ManualPaymentCubit extends Cubit<ManualPaymentState> {
  final ManualPaymentUseCase manualPaymentUseCase;
  ManualPaymentCubit({required this.manualPaymentUseCase})
      : super(ManualPaymentInitial());

  Future<void> manualPayment({
    required String formationId,
    String? additionalDiploma, // Make this parameter optional
  }) async {
    emit(ManualPaymentLoading());
    try {
      debugPrint(
          "Formation Id: $formationId, Additional Diploma: $additionalDiploma");
      final result = await manualPaymentUseCase.callback(
        formationId,
        additionalDiploma ?? "maroc",
      );

      result.fold(
        (l) {
          debugPrint(l.message);
          emit(ManualPaymentFailure(message: l.message));
        },
        (r) => emit(ManualPaymentLoaded(manualPayment: r)),
      );
    } on SocketException catch (e) {
      debugPrint("Socket error: $e");
      emit(ManualPaymentFailure(message: "Network error: ${e.toString()}"));
    } catch (e) {
      debugPrint("General error: $e");
      emit(ManualPaymentFailure(message: "An error occurred: ${e.toString()}"));
    }
  }
}
