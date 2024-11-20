import 'package:equatable/equatable.dart';

class DomainEntity extends Equatable {
  final int? id;
  final String? title;
  final int? sort;
  final String? description;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;

  DomainEntity(
      {required this.id,
      required this.title,
      required this.sort,
      required this.description,
      required this.active,
      required this.createdAt,
      required this.updatedAt});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, title, sort, description, active, createdAt, updatedAt];
}
