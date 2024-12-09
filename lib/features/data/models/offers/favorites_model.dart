import 'dart:convert';

import 'package:school_test_online/features/data/models/offers/offers_model.dart';
import 'package:school_test_online/features/data/models/offers/pivot_model.dart';
import 'package:school_test_online/features/domain/entities/offers/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  int? id;
  String? title;
  String? image;
  String? company;
  String? city;
  SalaryModel? salary;
  String? type;
  String? contract;
  String? nature;
  String? missions;
  String? skills;
  String? experience;
  int? periode;
  String? unit;
  bool? active;
  String? createdAt;
  String? updatedAt;
  bool? isFavorite;
  PivotModel? pivots;

  FavoriteModel(
      {this.id,
      this.title,
      this.image,
      this.company,
      this.city,
      this.salary,
      this.type,
      this.contract,
      this.nature,
      this.missions,
      this.skills,
      this.experience,
      this.periode,
      this.unit,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.isFavorite,
      this.pivots});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    company = json['company'];
    city = json['city'];
    if (json['salary'] is String) {
      try {
        Map<String, dynamic> parsedSalary = jsonDecode(json['salary']);
        salary = SalaryModel.fromJson(parsedSalary);
      } catch (e) {
        salary = null;
      }
    } else if (json['salary'] is Map<String, dynamic>) {
      salary = SalaryModel.fromJson(json['salary']);
    } else {
      salary = null;
    }
    type = json['type'];
    contract = json['contract'];
    nature = json['nature'];
    missions = json['missions'];
    skills = json['skills'];
    experience = json['experience'];
    periode = json['periode'];
    unit = json['unit'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFavorite = json['is_favorite'];
    pivots = json['pivot'] != null ? PivotModel.fromJson(json['pivot']) : null;
  }

  static List<FavoriteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FavoriteModel.fromJson(json)).toList();
  }
}
