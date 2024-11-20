import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/user/update_user_entity.dart';
import 'package:school_test_online/features/domain/use_cases/user/update_profile_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUserUseCase updateProfileUserUseCase;
  UpdateProfileCubit({required this.updateProfileUserUseCase})
      : super(UpdateProfileInitial());

  Future<void> updateProfileUser({
    required String name,
    required String address,
    required String phone,
    required String country,
  }) async {
    emit(UpdateProfileLoading());
    try {
      final result = await updateProfileUserUseCase.callback(
          name, address, phone, country);
      await Future.delayed(Duration(seconds: 1));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      result.fold((l) => emit(UpdateProfileFailure(message: l.message)),
          (r) => emit(UpdateProfileLoaded(updateUserProfile: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      emit(UpdateProfileFailure(message: e.message));
    } catch (e) {
      print("this is error $e");
      emit(UpdateProfileFailure(message: e.toString()));
    }
  }
}
