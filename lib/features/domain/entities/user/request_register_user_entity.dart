import 'package:equatable/equatable.dart';

class RequestRegisterUserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final String? address;
  final String? phone;
  final String? country;

  const RequestRegisterUserEntity(
      {this.name,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.address,
      this.phone,
      required this.country});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
