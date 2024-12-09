import 'package:equatable/equatable.dart';

class OffersEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final String? company;
  final String? city;
  final SalaryEntity? salary;
  final String? type;
  final String? contract;
  final String? nature;
  final String? missions;
  final String? skills;
  final String? experience;
  final int? periode;
  final String? unit;
  final bool? active;
  final String? createdAt;
  final String? updatedAt;
  final bool? isFavorite;

  const OffersEntity(
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        image,
        company,
        city,
        salary,
        type,
        contract,
        nature,
        missions,
        skills,
        experience,
        periode,
        unit,
        active,
        createdAt,
        updatedAt,
        isFavorite
      ];
}

class SalaryEntity extends Equatable {
  final String? min;
  final String? max;

  const SalaryEntity({this.min, this.max});
  @override
  // TODO: implement props
  List<Object?> get props => [min, max];
}
