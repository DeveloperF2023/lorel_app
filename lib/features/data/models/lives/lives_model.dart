import 'package:school_test_online/features/data/models/lives/zoom_response_model.dart';
import 'package:school_test_online/features/domain/entities/lives/lives_entity.dart';

class LivesModel extends LivesEntity {
  final int? id;
  final String? title;
  final String? startTime;
  final String? password;
  final int? groupId;
  final ZoomResponseModel? zoomResponses;
  final String? createdAt;
  final String? updatedAt;

  const LivesModel(
      {this.id,
      this.title,
      this.startTime,
      this.password,
      this.groupId,
      this.zoomResponses,
      this.createdAt,
      this.updatedAt})
      : super(
            id: id,
            title: title,
            startTime: startTime,
            password: password,
            groupId: groupId,
            zoomResponse: zoomResponses,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory LivesModel.fromJson(Map<String, dynamic> json) {
    return LivesModel(
      id: json['id'],
      title: json['title'],
      startTime: json['start_time'],
      password: json['password'],
      groupId: json['group_id'],
      zoomResponses: json['zoom_response'] != null
          ? ZoomResponseModel.fromJson(
              json['zoom_response']) // Parsing zoom_response
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  static List<LivesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LivesModel.fromJson(json)).toList();
  }
}
