part of 'get_conversations_cubit.dart';

sealed class GetConversationsState extends Equatable {
  const GetConversationsState();
}

final class GetConversationsInitial extends GetConversationsState {
  @override
  List<Object> get props => [];
}

final class GetConversationsLoading extends GetConversationsState {
  @override
  List<Object> get props => [];
}

final class GetConversationsLoaded extends GetConversationsState {
  final List<ChatEntity> conversations;

  const GetConversationsLoaded({required this.conversations});
  @override
  List<Object> get props => [conversations];
}

final class GetConversationsFailure extends GetConversationsState {
  final String message;

  const GetConversationsFailure({required this.message});
  @override
  List<Object> get props => [message];
}
