import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/lives/settings_lives_entity.dart';

class ZoomDataEntity extends Equatable {
  final String? uuid;
  final int? id;
  final String? hostId;
  final String? hostEmail;
  final String? topic;
  final int? type;
  final String? status;
  final String? startTime;
  final int? duration;
  final String? timezone;
  final String? agenda;
  final String? createdAt;
  final String? startUrl;
  final String? joinUrl;
  final String? password;
  final String? h323Password;
  final String? pstnPassword;
  final String? encryptedPassword;
  final SettingsLivesEntity? settings;
  final bool? preSchedule;

  const ZoomDataEntity(
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
      this.settings,
      this.preSchedule});
  @override
  List<Object?> get props => [
        uuid,
        id,
        hostId,
        hostEmail,
        topic,
        type,
        status,
        startTime,
        duration,
        timezone,
        agenda,
        createdAt,
        startUrl,
        joinUrl,
        password,
        h323Password,
        pstnPassword,
        encryptedPassword,
        settings,
        preSchedule
      ];
}
