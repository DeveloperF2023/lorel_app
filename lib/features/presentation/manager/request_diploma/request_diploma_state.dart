part of 'request_diploma_cubit.dart';

sealed class RequestDiplomaState extends Equatable {
  const RequestDiplomaState();
}

final class RequestDiplomaInitial extends RequestDiplomaState {
  @override
  List<Object> get props => [];
}

final class RequestDiplomaLoading extends RequestDiplomaState {
  @override
  List<Object> get props => [];
}

final class RequestDiplomaLoaded extends RequestDiplomaState {
  @override
  List<Object> get props => [];
}

final class RequestDiplomaFailure extends RequestDiplomaState {
  final String message;

  const RequestDiplomaFailure({required this.message});
  @override
  List<Object> get props => [message];
}
