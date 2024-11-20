import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/user/user_data_entity.dart';

class UpdateUserEntity extends Equatable {
  final UserDataEntity? user;
  final String? message;

  const UpdateUserEntity({required this.user, required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [user, message];
}
