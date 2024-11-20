import 'package:school_test_online/features/data/models/courses/pdf_model.dart';
import 'package:school_test_online/features/data/models/lives/lives_model.dart';
import 'package:school_test_online/features/domain/entities/courses/current_courses_entity.dart';

class CurrentCourseModel extends CurrentCoursesEntity {
  int? id;
  String? title;
  String? description;
  String? image;
  String? video;
  List<PdfModel>? pdf;
  int? sort;
  bool? active;
  String? publishedAt;
  int? userId;
  int? formationId;
  String? createdAt;
  String? updatedAt;
  String? startedAt;
  String? finishedAt;
  List<LivesModel>? lives;

  CurrentCourseModel(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.video,
      this.pdf,
      this.sort,
      this.active,
      this.publishedAt,
      this.userId,
      this.formationId,
      this.createdAt,
      this.updatedAt,
      this.startedAt,
      this.finishedAt,
      this.lives});

  CurrentCourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    if (json['pdf'] != null) {
      pdf = <PdfModel>[];
      json['pdf'].forEach((v) {
        pdf!.add(PdfModel.fromJson(v));
      });
    }
    sort = json['sort'];
    active = json['active'];
    publishedAt = json['published_at'];
    userId = json['user_id'];
    formationId = json['formation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    if (json['lives'] != null) {
      lives = <LivesModel>[];
      json['lives'].forEach((v) {
        lives!.add(LivesModel.fromJson(v));
      });
    }
  }
}
