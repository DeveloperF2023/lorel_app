import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

import '../domain/domain_model.dart';
import 'additional_diploma_model.dart';

class CoursesModel extends CoursesEntity {
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
  DomainModel? domain;

  CoursesModel(
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
      this.domain});

  CoursesModel.fromJson(Map<String, dynamic> json) {
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
    domain =
        json['domain'] != null ? DomainModel.fromJson(json['domain']) : null;
  }
  static List<CoursesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CoursesModel.fromJson(json)).toList();
  }
}
