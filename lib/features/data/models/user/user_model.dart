import 'package:school_test_online/features/data/models/user/user_data_model.dart';
import 'package:school_test_online/features/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  UserDataModel? users;

  String? token;

  String? tokenType;

  UserModel({this.users, this.token, this.tokenType});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserDataModel.fromJson(json['user']) : null;
    token = json['token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = users!.toJson();
    }
    data['token'] = token;
    data['token_type'] = tokenType;
    return data;
  }
}
