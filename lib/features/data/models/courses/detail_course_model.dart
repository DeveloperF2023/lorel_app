import 'package:school_test_online/features/data/models/courses/pdf_model.dart';
import 'package:school_test_online/features/data/models/lives/lives_model.dart';
import 'package:school_test_online/features/domain/entities/courses/detail_course_entity.dart';

class DetailCourseModel extends DetailCourseEntity {
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

  DetailCourseModel(
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

  factory DetailCourseModel.fromJson(Map<String, dynamic> json) {
    return DetailCourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      video: json['video'],
      pdf: (json['pdf'] as List).map((e) => PdfModel.fromJson(e)).toList(),
      sort: json['sort'],
      active: json['active'],
      publishedAt: json['published_at'],
      userId: json['user_id'],
      formationId: json['formation_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      startedAt: json['started_at'],
      finishedAt: json['finished_at'],
    );
  }

  static List<DetailCourseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DetailCourseModel.fromJson(json)).toList();
  }
}
