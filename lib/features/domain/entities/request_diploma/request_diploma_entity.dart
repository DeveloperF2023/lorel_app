import 'package:equatable/equatable.dart';

class RequestDiplomaEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? birth;
  final String? identity;

  const RequestDiplomaEntity(
      {this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.birth,
      this.identity});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
