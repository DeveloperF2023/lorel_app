import 'package:school_test_online/features/domain/entities/user/request_register_user_entity.dart';

class RequestRegisterUserModel extends RequestRegisterUserEntity {
  String? name;

  String? email;

  String? password;

  String? passwordConfirmation;

  String? address;

  String? phone;

  String? country;

  RequestRegisterUserModel(
      {this.name,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.address,
      this.phone,
      this.country})
      : super(
            name: name,
            email: email,
            password: password,
            passwordConfirmation: passwordConfirmation,
            address: address,
            phone: phone,
            country: country);

  factory RequestRegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RequestRegisterUserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      address: json['address'],
      phone: json['phone'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['address'] = address;
    data['phone'] = phone;
    data['country'] = country;
    return data;
  }
}
