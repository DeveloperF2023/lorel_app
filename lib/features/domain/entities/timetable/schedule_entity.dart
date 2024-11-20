import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/chat/group_entity.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

class ScheduleEntity extends Equatable {
  final String? start;
  final String? end;
  final String? day;
  final String? date;
  final CoursesEntity? formation;
  final GroupEntity? group;

  const ScheduleEntity(
      {this.start, this.end, this.day, this.date, this.formation, this.group});
  @override
  // TODO: implement props
  List<Object?> get props => [start, end, day, date, formation, group];
}
