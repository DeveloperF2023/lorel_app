import 'package:school_test_online/features/domain/entities/offers/offers_entity.dart';

class OffersModel extends OffersEntity {
  int? id;
  String? title;
  String? image;
  String? company;
  String? city;
  String? salary;
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

  OffersModel(
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
      this.isFavorite});

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    company = json['company'];
    city = json['city'];
    salary = json['salary'];
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
  }

  static List<OffersModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OffersModel.fromJson(json)).toList();
  }
}
