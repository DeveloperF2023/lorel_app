import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/use_cases/chat/attach_file_to_conversation_use_case.dart';

import '../../../../domain/entities/chat/send_message_response_entity.dart';

part 'attach_file_to_conversation_state.dart';

class AttachFileToConversationCubit
    extends Cubit<AttachFileToConversationState> {
  final AttachFileToConversationsUseCase attachFileToConversationsUseCase;
  AttachFileToConversationCubit(
      {required this.attachFileToConversationsUseCase})
      : super(AttachFileToConversationInitial());
  Future<void> attachFile(
      {required int conversationId,
      required File file,
      required String type}) async {
    emit(AttachFileToConversationLoading());
    try {
      final result = await attachFileToConversationsUseCase.callback(
          conversationId, file, type);
      result.fold(
        (l) => emit(AttachFileToConversationFailure(message: l.message)),
        (r) {
          emit(AttachFileToConversationLoaded(attachFile: r));
        },
      );
      print('File attached: $result');
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(AttachFileToConversationFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(AttachFileToConversationFailure(message: e.toString()));
    }
  }
}
