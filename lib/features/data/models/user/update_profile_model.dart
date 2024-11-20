import 'package:school_test_online/features/data/models/user/user_data_model.dart';
import 'package:school_test_online/features/domain/entities/user/update_user_entity.dart';

class UpdateProfileModel extends UpdateUserEntity {
  UserDataModel? user;
  String? message;

  UpdateProfileModel({this.user, this.message})
      : super(user: user, message: message);

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      user: json['user'] != null ? UserDataModel.fromJson(json['user']) : null,
      message: json['message'],
    );
  }
}
