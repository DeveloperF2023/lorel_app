import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final int? id;
  final String? name;
  final String? role;
  final String? address;
  final String? country;
  final String? image;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  const UserDataEntity({
    this.id,
    this.name,
    this.role,
    this.address,
    this.country,
    this.image,
    this.active,
    this.createdAt,
    this.updatedAt,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        role,
        address,
        country,
        image,
        active,
        createdAt,
        updatedAt,
      ];
}
