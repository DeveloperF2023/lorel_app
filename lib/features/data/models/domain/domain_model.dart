import 'package:school_test_online/features/domain/entities/domain/domain_entity.dart';

class DomainModel extends DomainEntity {
  int? id;
  String? title;
  int? sort;
  String? description;
  bool? active;
  String? createdAt;
  String? updatedAt;

  DomainModel(
      {this.id,
      this.title,
      this.sort,
      this.description,
      this.active,
      this.createdAt,
      this.updatedAt})
      : super(
            id: id,
            title: title,
            sort: sort,
            description: description,
            active: active,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      id: json['id'],
      title: json['title'],
      sort: json['sort'],
      description: json['description'],
      active: json['active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sort'] = sort;
    data['description'] = description;
    data['active'] = active;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<DomainModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DomainModel.fromJson(json)).toList();
  }
}
