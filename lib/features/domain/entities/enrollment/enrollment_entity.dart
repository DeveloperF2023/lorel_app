import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/group_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

class EnrollmentEntity extends Equatable {
  final int? id;
  final int? userId;
  final int? groupId;
  final int? formationId;
  final String? enrolledAt;
  final String? leftAt;
  final String? additionalDiplomas;
  final String? status;
  final String? progress;
  final bool? finished;
  final GroupEntity? group;
  final CoursesEntity? formation;

  const EnrollmentEntity(
      {this.id,
      this.userId,
      this.groupId,
      this.formationId,
      this.enrolledAt,
      this.leftAt,
      this.additionalDiplomas,
      this.status,
      this.progress,
      this.finished,
      this.group,
      this.formation});
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        userId,
        groupId,
        formationId,
        enrolledAt,
        leftAt,
        additionalDiplomas,
        status,
        progress,
        finished,
        group,
        formation
      ];
}
