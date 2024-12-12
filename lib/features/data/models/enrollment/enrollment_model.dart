import 'package:school_test_online/features/data/models/chat/group_model.dart';
import 'package:school_test_online/features/data/models/courses/courses_model.dart';
import 'package:school_test_online/features/domain/entities/enrollment/enrollment_entity.dart';

class EnrollmentModel extends EnrollmentEntity {
  int? id;

  int? userId;

  int? groupId;

  int? formationId;

  String? enrolledAt;

  String? leftAt;

  String? additionalDiplomas;

  String? status;

  String? progress;

  bool? finished;

  GroupModel? group;

  CoursesModel? formation;

  EnrollmentModel(
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

  EnrollmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    formationId = json['formation_id'];
    enrolledAt = json['enrolled_at'];
    leftAt = json['left_at'];
    additionalDiplomas = json['additional_diplomas'];
    status = json['status'];
    progress = json['progress'];
    finished = json['finished'];
    group = json['group'] != null ? GroupModel.fromJson(json['group']) : null;
    formation = json['formation'] != null
        ? CoursesModel.fromJson(json['formation'])
        : null;
  }

  static List<EnrollmentModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EnrollmentModel.fromJson(json)).toList();
  }
}
