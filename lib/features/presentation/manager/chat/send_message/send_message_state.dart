part of 'send_message_cubit.dart';

sealed class SendMessageState extends Equatable {
  const SendMessageState();
}

final class SendMessageInitial extends SendMessageState {
  @override
  List<Object> get props => [];
}

final class SendMessageLoading extends SendMessageState {
  @override
  List<Object> get props => [];
}

final class SendMessageLoaded extends SendMessageState {
  final SendMessageResponseEntity sendMessage;

  const SendMessageLoaded({required this.sendMessage});
  @override
  List<Object> get props => [];
}

final class SendMessageFailure extends SendMessageState {
  final String message;

  const SendMessageFailure({required this.message});
  @override
  List<Object> get props => [message];
}
