import 'package:school_test_online/features/domain/entities/user/response_upload_avatar_entity.dart';

class ResponseUploadAvatarModel extends ResponseUploadAvatarEntity {
  String? message;
  String? url;

  ResponseUploadAvatarModel({this.message, this.url});

  ResponseUploadAvatarModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    url = json['url'];
  }
}
