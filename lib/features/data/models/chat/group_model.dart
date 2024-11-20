import 'package:school_test_online/features/data/models/chat/teacher_model.dart';
import 'package:school_test_online/features/domain/entities/chat/group_entity.dart';

import '../courses/courses_model.dart';

class GroupModel extends GroupEntity {
  final int? id;
  final String? name;
  final bool? active;
  final int? userId;
  final int? formationId;
  final String? createdAt;
  final String? updatedAt;
  final TeacherModel? teachers;
  final CoursesModel? courses;

  GroupModel(
      {this.id,
      this.name,
      this.active,
      this.userId,
      this.formationId,
      this.createdAt,
      this.updatedAt,
      this.teachers,
      this.courses})
      : super(
          id: id,
          name: name,
          active: active,
          userId: userId,
          formationId: formationId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          teacher: teachers,
          formation: courses,
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      userId: json['user_id'],
      formationId: json['formation_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      teachers: json['teacher'] != null
          ? TeacherModel.fromJson(json['teacher'])
          : null,
      courses: json['formation'] != null
          ? CoursesModel.fromJson(json['formation'])
          : null,
    );
  }
}
