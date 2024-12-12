import 'package:school_test_online/features/data/models/lives/settings_zoom_model.dart';
import 'package:school_test_online/features/domain/entities/lives/zoom_data_entity.dart';

class ZoomDataModel extends ZoomDataEntity {
  String? uuid;

  int? id;

  String? hostId;

  String? hostEmail;

  String? topic;

  int? type;

  String? status;

  String? startTime;

  int? duration;

  String? timezone;

  String? agenda;

  String? createdAt;

  String? startUrl;

  String? joinUrl;

  String? password;

  String? h323Password;

  String? pstnPassword;

  String? encryptedPassword;
  SettingsZoomModel? settingsZoom;

  bool? preSchedule;

  ZoomDataModel(
      {this.uuid,
      this.id,
      this.hostId,
      this.hostEmail,
      this.topic,
      this.type,
      this.status,
      this.startTime,
      this.duration,
      this.timezone,
      this.agenda,
      this.createdAt,
      this.startUrl,
      this.joinUrl,
      this.password,
      this.h323Password,
      this.pstnPassword,
      this.encryptedPassword,
      this.settingsZoom,
      this.preSchedule});

  factory ZoomDataModel.fromJson(Map<String, dynamic> json) {
    return ZoomDataModel(
        uuid: json['uuid'],
        id: json['id'],
        hostId: json['host_id'],
        hostEmail: json['host_email'],
        topic: json['topic'],
        type: json['type'],
        status: json['status'],
        startTime: json['start_time'],
        duration: json['duration'],
        timezone: json['timezone'],
        agenda: json['agenda'],
        createdAt: json['created_at'],
        startUrl: json['start_url'],
        joinUrl: json['join_url'],
        password: json['password'],
        h323Password: json['h323_password'],
        pstnPassword: json['pstn_password'],
        encryptedPassword: json['encrypted_password'],
        settingsZoom: json['settings'] != null
            ? SettingsZoomModel.fromJson(json['settings'])
            : null,
        preSchedule: json['pre_schedule']);
  }
}
