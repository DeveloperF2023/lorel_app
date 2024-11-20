import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/send_message_response_entity.dart';
import 'package:school_test_online/features/domain/use_cases/chat/send_message_use_case.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessagesUseCase sendMessagesUseCase;
  final StreamController<void> _messageSentController =
      StreamController<void>.broadcast();
  Stream<void> get messageSentStream => _messageSentController.stream;
  SendMessageCubit({
    required this.sendMessagesUseCase,
  }) : super(SendMessageInitial());

  Future<void> sendMessage(
      {required int conversationId, required String content}) async {
    emit(SendMessageLoading());
    try {
      final result =
          await sendMessagesUseCase.callback(conversationId, content);
      result.fold(
        (l) => emit(SendMessageFailure(message: l.message)),
        (r) {
          emit(SendMessageLoaded(sendMessage: r));
          _messageSentController.add(null); // Notify listeners
        },
      );
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(SendMessageFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(SendMessageFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messageSentController.close();
    return super.close();
  }
}
