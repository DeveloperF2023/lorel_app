import 'package:school_test_online/features/domain/entities/request_diploma/request_diploma_entity.dart';

class RequestDiplomaModel extends RequestDiplomaEntity {
  String? firstName;

  String? lastName;

  String? phone;

  String? address;

  String? birth;

  String? identity;

  RequestDiplomaModel(
      {this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.birth,
      this.identity});

  RequestDiplomaModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    address = json['address'];
    birth = json['birth'];
    identity = json['identity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'address': address,
      'birth': birth,
      'identity': identity,
    };
  }
}
