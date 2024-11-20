import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  String? title;
  String? message;
  String? type;
  String? date;
  NotificationEntity({this.title, this.message, this.date, this.type});
  @override
  // TODO: implement props
  List<Object?> get props => [title, message, date, type];
}
