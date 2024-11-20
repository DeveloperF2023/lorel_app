import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/courses/additional_diplomas_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/current_courses_entity.dart';
import 'package:school_test_online/features/domain/entities/domain/domain_entity.dart';

class CoursesByStatusEntity extends Equatable {
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
  final String? progress;
  final String? status;
  final CurrentCoursesEntity? currentCourse;
  final DomainEntity? domain;

  CoursesByStatusEntity(
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
      this.progress,
      this.status,
      this.currentCourse,
      this.domain});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
