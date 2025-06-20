import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/entities/notifications/notification_entity.dart';
import 'package:school_test_online/features/domain/use_cases/notifications/fetch_notifications_use_case.dart';

part 'get_notifications_state.dart';

class GetNotificationsCubit extends Cubit<GetNotificationsState> {
  final FetchNotificationUseCase fetchNotificationUseCase;
  GetNotificationsCubit({required this.fetchNotificationUseCase})
      : super(GetNotificationsInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    try {
      final result = await fetchNotificationUseCase.callback();
      result.fold((l) => emit(GetNotificationsFailure(message: l.message)),
          (r) => emit(GetNotificationsLoaded(notifications: r)));
      debugPrint("Result Offers $result");
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetNotificationsFailure(message: e.toString()));
    } catch (e) {
      debugPrint("this is error $e");
      debugPrint("failed registration");
      emit(GetNotificationsFailure(message: e.toString()));
    }
  }
}
