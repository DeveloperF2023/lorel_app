import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/chat/chat_entity.dart';
import 'package:school_test_online/features/domain/use_cases/chat/get_conversations_use_case.dart';

part 'get_conversations_state.dart';

class GetConversationsCubit extends Cubit<GetConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  GetConversationsCubit({required this.fetchConversationsUseCase})
      : super(GetConversationsInitial());

  Future<void> fetchConversations() async {
    emit(GetConversationsLoading());
    try {
      final result = await fetchConversationsUseCase.callback();
      result.fold((l) => emit(GetConversationsFailure(message: l.message)),
          (r) => emit(GetConversationsLoaded(conversations: r)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetConversationsFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetConversationsFailure(message: e.toString()));
    }
  }
}
