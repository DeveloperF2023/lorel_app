import 'package:school_test_online/features/domain/entities/courses/pivot_entity.dart';

class PivotModel extends PivotEntity {
  int? userId;
  int? courseId;
  String? startedAt;
  Null? finishedAt;
  Null? expiredAt;

  PivotModel(
      {this.userId,
      this.courseId,
      this.startedAt,
      this.finishedAt,
      this.expiredAt});

  PivotModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    expiredAt = json['expired_at'];
  }
}
