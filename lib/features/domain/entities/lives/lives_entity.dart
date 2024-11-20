import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/lives/zoom_response_entity.dart';

class LivesEntity extends Equatable {
  final int? id;
  final String? title;
  final String? startTime;
  final String? password;
  final int? groupId;
  final ZoomResponseEntity? zoomResponse;
  final String? createdAt;
  final String? updatedAt;
  final int? courseId;
  const LivesEntity(
      {this.id,
      this.title,
      this.startTime,
      this.password,
      this.groupId,
      this.zoomResponse,
      this.createdAt,
      this.updatedAt,
      this.courseId});
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        startTime,
        password,
        groupId,
        zoomResponse,
        createdAt,
        updatedAt,
        courseId
      ];
}
