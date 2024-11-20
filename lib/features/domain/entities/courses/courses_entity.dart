import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/domain/domain_entity.dart';

import 'additional_diplomas_entity.dart';

class CoursesEntity extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final int? sort;
  final String? description;
  final int? price;
  final bool? active;
  final int? periode;
  final String? units;
  final List<AdditionalDiplomasEntity>? additionalDiplomas;
  final int? domainId;
  final String? startAt;
  final String? createdAt;
  final String? updatedAt;
  final DomainEntity? domain;

  const CoursesEntity(
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

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        image,
        sort,
        description,
        price,
        active,
        periode,
        units,
        additionalDiplomas,
        domainId,
        startAt,
        createdAt,
        updatedAt,
        domain
      ];
}
