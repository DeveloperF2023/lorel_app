import 'package:equatable/equatable.dart';

class PivotEntity extends Equatable {
  final int? userId;
  final int? courseId;
  final String? startedAt;
  final Null? finishedAt;
  final Null? expiredAt;

  PivotEntity(
      {this.userId,
      this.courseId,
      this.startedAt,
      this.finishedAt,
      this.expiredAt});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
