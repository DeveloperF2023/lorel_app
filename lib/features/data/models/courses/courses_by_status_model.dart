import 'package:school_test_online/features/domain/entities/courses/courses_by_status_entity.dart';

import '../domain/domain_model.dart';
import 'additional_diploma_model.dart';
import 'current_course_model.dart';

class CoursesByStatusModel extends CoursesByStatusEntity {
  int? id;
  String? title;
  String? image;
  int? sort;
  String? description;
  int? price;
  bool? active;
  int? periode;
  String? units;
  List<AdditionalDiplomasModel>? additionalDiplomas;
  int? domainId;
  String? startAt;
  String? createdAt;
  String? updatedAt;
  String? progress;
  String? status;
  CurrentCourseModel? currentCourse;
  DomainModel? domain;

  CoursesByStatusModel(
      {this.id,
      this.title,
      this.image,
      this.sort,
      this.description,
      this.price,
      this.active,
      this.periode,
      this.units,
      this.additionalDiplomas,
      this.domainId,
      this.startAt,
      this.createdAt,
      this.updatedAt,
      this.progress,
      this.status,
      this.currentCourse,
      this.domain});

  CoursesByStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    sort = json['sort'];
    description = json['description'];
    price = json['price'];
    active = json['active'];
    periode = json['periode'];
    units = json['units'];
    if (json['additional_diplomas'] != null) {
      additionalDiplomas = <AdditionalDiplomasModel>[];
      json['additional_diplomas'].forEach((v) {
        additionalDiplomas!.add(AdditionalDiplomasModel.fromJson(v));
      });
    }
    domainId = json['domain_id'];
    startAt = json['start_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    progress = json['progress'];
    status = json['status'];
    currentCourse = json['current_course'] != null
        ? CurrentCourseModel.fromJson(json['current_course'])
        : null;
    domain =
        json['domain'] != null ? DomainModel.fromJson(json['domain']) : null;
  }
  static List<CoursesByStatusModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CoursesByStatusModel.fromJson(json)).toList();
  }
}
