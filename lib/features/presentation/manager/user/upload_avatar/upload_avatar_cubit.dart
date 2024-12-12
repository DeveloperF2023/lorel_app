import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_test_online/features/domain/use_cases/user/upload_avatar_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'upload_avatar_state.dart';

class UploadAvatarCubit extends Cubit<UploadAvatarState> {
  final UploadAvatarUseCase uploadAvatarUseCase;
  UploadAvatarCubit({required this.uploadAvatarUseCase})
      : super(UploadAvatarInitial());

  Future<void> uploadAvatarUser({
    required String avatar,
  }) async {
    emit(UploadAvatarLoading());
    try {
      final result = await uploadAvatarUseCase.callback(avatar);
      await Future.delayed(const Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePicture', avatar);
      result.fold((l) {
        emit(UploadAvatarFailure(message: l.message));
        debugPrint('Error: ${l.message}');
      }, (r) => emit(UploadAvatarLoaded(uploadAvatar: r.url!)));
    } on SocketException catch (e) {
      debugPrint("this is error $e");
      emit(UploadAvatarFailure(message: e.message));
    } catch (e) {
      debugPrint("this is error $e");
      emit(UploadAvatarFailure(message: e.toString()));
    }
  }

  Future<void> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final imageUrl = prefs.getString('profilePicture') ?? '';
    emit(UploadAvatarLoaded(uploadAvatar: imageUrl));
  }
}
