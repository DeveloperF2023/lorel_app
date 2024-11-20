import 'package:school_test_online/features/domain/entities/chat/teacher_entity.dart';

class TeacherModel extends TeacherEntity {
  final int? id;
  final String? name;
  final String? role;
  final String? address;
  final String? country;
  final String? image;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;

  TeacherModel(
      {this.id,
      this.name,
      this.role,
      this.address,
      this.country,
      this.image,
      this.active,
      this.createdAt,
      this.updatedAt});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      address: json['address'],
      country: json['country'],
      image: json['image'],
      active: json['active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
