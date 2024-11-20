import 'package:school_test_online/features/data/models/chat/group_model.dart';
import 'package:school_test_online/features/data/models/courses/courses_model.dart';
import 'package:school_test_online/features/domain/entities/timetable/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  final String? start;
  final String? end;
  final String? day;
  final String? date;
  final CoursesModel? formation;
  final GroupModel? group;

  const ScheduleModel(
      {this.start, this.end, this.day, this.date, this.formation, this.group});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      start: json['start'],
      end: json['end'],
      day: json['day'],
      date: json['date'],
      formation: json['formation'] != null
          ? CoursesModel.fromJson(json['formation'])
          : null,
      group: json['group'] != null ? GroupModel.fromJson(json['group']) : null,
    );
  }
  static List<ScheduleModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ScheduleModel.fromJson(json)).toList();
  }
}
