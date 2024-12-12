import 'package:equatable/equatable.dart';

class WorkshopEntity extends Equatable {
  final int? id;
  final String? title;
  final String? dateFrom;
  final String? dateTo;
  final String? description;
  final String? image;
  final Null participants;
  final String? price;
  final String? address;
  final String? about;
  final String? link;
  final String? video;
  final Null publishedAt;
  final int? active;
  final String? createdAt;
  final String? updatedAt;
  final int? participantsCount;
  final bool? free;

  const WorkshopEntity(
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
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dateFrom,
        dateTo,
        description,
        image,
        participants,
        price,
        address,
        about,
        link,
        video,
        publishedAt,
        active,
        createdAt,
        updatedAt,
        participantsCount,
        free
      ];
}
