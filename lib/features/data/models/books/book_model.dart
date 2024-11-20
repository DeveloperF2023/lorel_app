import 'package:school_test_online/features/domain/entities/book/book_entity.dart';

class BookModel extends BookEntity {
  int? id;
  String? title;
  String? pdf;
  String? image;
  String? author;
  String? domain;
  bool? active;
  String? createdAt;
  String? updatedAt;

  BookModel(
      {this.id,
      this.title,
      this.pdf,
      this.image,
      this.author,
      this.domain,
      this.active,
      this.createdAt,
      this.updatedAt});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pdf = json['pdf'];
    image = json['image'];
    author = json['author'];
    domain = json['domain'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  static List<BookModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BookModel.fromJson(json)).toList();
  }
}
