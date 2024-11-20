import 'package:school_test_online/features/domain/entities/notifications/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  String? title;
  String? message;
  String? type;
  String? date;

  NotificationModel({this.title, this.message, this.type, this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    type = json['type'];
    date = json['date'];
  }

  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }
}
