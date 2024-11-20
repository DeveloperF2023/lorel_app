part of 'manual_payment_cubit.dart';

sealed class ManualPaymentState extends Equatable {
  const ManualPaymentState();
}

final class ManualPaymentInitial extends ManualPaymentState {
  @override
  List<Object> get props => [];
}

final class ManualPaymentLoading extends ManualPaymentState {
  @override
  List<Object> get props => [];
}

final class ManualPaymentLoaded extends ManualPaymentState {
  final ManualPaymentResponseEntity manualPayment;

  const ManualPaymentLoaded({required this.manualPayment});
  @override
  List<Object> get props => [manualPayment];
}

final class ManualPaymentFailure extends ManualPaymentState {
  final String message;

  const ManualPaymentFailure({required this.message});
  @override
  List<Object> get props => [message];
}
