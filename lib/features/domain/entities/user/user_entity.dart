import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/user/user_data_entity.dart';

class UserEntity extends Equatable {
  UserDataEntity? user;
  String? token;
  String? tokenType;
  UserEntity({this.user, this.token, this.tokenType});
  @override
  // TODO: implement props
  List<Object?> get props => [user, token, tokenType];
}
