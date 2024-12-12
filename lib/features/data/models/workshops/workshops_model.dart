import 'package:school_test_online/features/domain/entities/workshop/workshop_entity.dart';

class WorkshopModel extends WorkshopEntity {
  int? id;

  String? title;

  String? dateFrom;

  String? dateTo;

  String? description;

  String? image;

  Null participants;

  String? price;

  String? address;

  String? about;

  String? link;

  String? video;

  Null publishedAt;

  int? active;

  String? createdAt;

  String? updatedAt;

  int? participantsCount;

  bool? free;

  WorkshopModel(
      {this.id,
      this.title,
      this.dateFrom,
      this.dateTo,
      this.description,
      this.image,
      this.participants,
      this.price,
      this.address,
      this.about,
      this.link,
      this.video,
      this.publishedAt,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.participantsCount,
      this.free});

  WorkshopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    description = json['description'];
    image = json['image'];
    participants = json['participants'];
    price = json['price'];
    address = json['address'];
    about = json['about'];
    link = json['link'];
    video = json['video'];
    publishedAt = json['published_at'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    participantsCount = json['participants_count'];
    free = json['free'];
  }
  static List<WorkshopModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => WorkshopModel.fromJson(json)).toList();
  }
}
