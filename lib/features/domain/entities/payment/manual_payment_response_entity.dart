import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/courses/courses_entity.dart';

import '../enrollment/enrollment_entity.dart';

class ManualPaymentResponseEntity extends Equatable {
  final String? message;
  final EnrollmentEntity? enrollment;
  final CoursesEntity? formation;

  const ManualPaymentResponseEntity(
      {this.message, this.enrollment, this.formation});
  @override
  // TODO: implement props
  List<Object?> get props => [message, enrollment, formation];
}
