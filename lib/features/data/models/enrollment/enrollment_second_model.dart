import '../../../domain/entities/enrollment/enrollment_second_entity.dart';
import '../chat/group_model.dart';
import '../courses/courses_model.dart';

class EnrollmentSecondModel extends EnrollmentSecondEntity {
  int? id;
  int? userId;
  int? groupId;
  String? formationId;
  String? enrolledAt;
  String? leftAt;
  String? additionalDiplomas;
  String? status;
  String? progress;
  bool? finished;
  GroupModel? group;
  CoursesModel? formation;

  EnrollmentSecondModel(
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

  EnrollmentSecondModel.fromJson(Map<String, dynamic> json) {
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

  static List<EnrollmentSecondModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => EnrollmentSecondModel.fromJson(json))
        .toList();
  }
}
