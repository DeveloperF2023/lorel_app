import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/courses/pdf_entity.dart';

import '../lives/lives_entity.dart';

class DetailCourseEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? video;
  final List<PdfEntity>? pdf;
  final int? sort;
  final bool? active;
  final String? publishedAt;
  final int? userId;
  final int? formationId;
  final String? createdAt;
  final String? updatedAt;
  final String? startedAt;
  final String? finishedAt;
  final bool? isLast;
  final List<LivesEntity>? lives;

  const DetailCourseEntity(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.video,
      this.pdf,
      this.sort,
      this.active,
      this.publishedAt,
      this.userId,
      this.formationId,
      this.createdAt,
      this.updatedAt,
      this.startedAt,
      this.finishedAt,
        this.isLast,
      this.lives});
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        video,
        pdf,
        sort,
        active,
        publishedAt,
        userId,
        formationId,
        createdAt,
        updatedAt,
        startedAt,
        finishedAt,
    isLast,
        lives
      ];
}
