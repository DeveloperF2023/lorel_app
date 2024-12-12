import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int? id;
  final String? title;
  final String? pdf;
  final String? image;
  final String? author;
  final String? domain;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;

  const BookEntity(
      {this.id,
      this.title,
      this.pdf,
      this.image,
      this.author,
      this.domain,
      this.active,
      this.createdAt,
      this.updatedAt});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, pdf, image, author, domain, active, createdAt, updatedAt];
}
