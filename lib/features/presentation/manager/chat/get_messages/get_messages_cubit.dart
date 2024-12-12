import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/chat/message_entity.dart';
import 'package:school_test_online/features/domain/use_cases/chat/get_messages_use_case.dart';

import '../../../../data/models/chat/message_model.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  final FetchMessagesUseCase fetchMessagesUseCase;
  GetMessagesCubit({required this.fetchMessagesUseCase})
      : super(GetMessagesInitial());

  Future<void> fetchMessages({required int conversationId}) async {
    emit(GetMessagesLoading());
    try {
      final result = await fetchMessagesUseCase.callback(conversationId);
      result.fold((l) => emit(GetMessagesFailure(message: l.message)),
          (r) => emit(GetMessagesLoaded(messages: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetMessagesFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetMessagesFailure(message: e.toString()));
    }
  }

  void addMessage(MessagesModel newMessage) {
    if (state is GetMessagesLoaded) {
      final currentMessages = (state as GetMessagesLoaded).messages;

      final updatedMessages = List<MessageEntity>.from(currentMessages)
        ..add(newMessage);

      emit(GetMessagesLoaded(messages: updatedMessages));
    } else {
      print("Cannot add message because the state is not GetMessagesLoaded");
    }
  }
}
