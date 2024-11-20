import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/message_entity.dart';
import 'package:school_test_online/features/domain/use_cases/chat/get_messages_use_case.dart';

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
      print("this is error $e");
      print("failed registration");
      emit(GetMessagesFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetMessagesFailure(message: e.toString()));
    }
  }
}
