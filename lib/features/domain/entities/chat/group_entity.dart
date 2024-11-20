import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/teacher_entity.dart';

import '../courses/courses_entity.dart';

class GroupEntity extends Equatable {
  final int? id;
  final String? name;
  final bool? active;
  final int? userId;
  final int? formationId;
  final String? createdAt;
  final String? updatedAt;
  final TeacherEntity? teacher;
  final CoursesEntity? formation;

  const GroupEntity(
      {this.id,
      this.name,
      this.active,
      this.userId,
      this.formationId,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.formation});
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        active,
        userId,
        formationId,
        createdAt,
        updatedAt,
        teacher,
        formation
      ];
}
