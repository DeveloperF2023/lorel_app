import 'package:school_test_online/features/domain/entities/user/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  int? id;
  String? name;
  String? role;
  String? address;
  String? country;
  String? image;
  bool? active;
  String? createdAt;
  String? updatedAt;

  UserDataModel(
      {this.id,
      this.name,
      this.role,
      this.address,
      this.country,
      this.image,
      this.active,
      this.createdAt,
      this.updatedAt});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    address = json['address'];
    country = json['country'];
    image = json['image'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['address'] = address;
    data['country'] = country;
    data['image'] = image;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
