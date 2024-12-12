import 'dart:convert';

import 'package:school_test_online/features/data/models/offers/offers_model.dart';
import 'package:school_test_online/features/domain/entities/offers/detail_offer_entity.dart';

class DetailOfferModel extends DetailOfferEntity {
  int? id;

  String? title;

  String? image;

  String? company;

  String? city;
  SalaryModel salaries;

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

  bool? ifFavorite;

  DetailOfferModel({
    this.id,
    this.title,
    this.image,
    this.company,
    this.city,
    required this.salaries,
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
    this.ifFavorite,
  }) : super(
          id: id,
          title: title,
          image: image,
          company: company,
          city: city,
          salary: salaries,
          type: type,
          contract: contract,
          nature: nature,
          missions: missions,
          skills: skills,
          experience: experience,
          periode: periode,
          unit: unit,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
          ifFavorite: ifFavorite,
        );

  factory DetailOfferModel.fromJson(Map<String, dynamic> json) {
    SalaryModel? parsedSalaries;

    // Parsing salary field
    if (json['salary'] is String) {
      try {
        Map<String, dynamic> salaryJson = jsonDecode(json['salary']);
        parsedSalaries = SalaryModel.fromJson(salaryJson);
      } catch (e) {
        print("Error decoding salary string: $e");
      }
    } else if (json['salary'] is Map<String, dynamic>) {
      try {
        parsedSalaries = SalaryModel.fromJson(json['salary']);
      } catch (e) {
        print("Error parsing salary map: $e");
      }
    }

    return DetailOfferModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      company: json['company'],
      city: json['city'],
      salaries: parsedSalaries!,
      type: json['type'],
      contract: json['contract'],
      nature: json['nature'],
      missions: json['missions'],
      skills: json['skills'],
      experience: json['experience'],
      periode: json['periode'],
      unit: json['unit'],
      active: json['active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      ifFavorite: json['if_favorite'],
    );
  }
}
