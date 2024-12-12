part of 'attach_file_to_conversation_cubit.dart';

sealed class AttachFileToConversationState extends Equatable {
  const AttachFileToConversationState();
}

final class AttachFileToConversationInitial
    extends AttachFileToConversationState {
  @override
  List<Object> get props => [];
}

final class AttachFileToConversationLoading
    extends AttachFileToConversationState {
  @override
  List<Object> get props => [];
}

final class AttachFileToConversationLoaded
    extends AttachFileToConversationState {
  final SendMessageResponseEntity attachFile;

  const AttachFileToConversationLoaded({required this.attachFile});
  @override
  List<Object> get props => [attachFile];
}

final class AttachFileToConversationFailure
    extends AttachFileToConversationState {
  final String message;

  const AttachFileToConversationFailure({required this.message});
  @override
  List<Object> get props => [message];
}
