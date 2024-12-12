import 'package:school_test_online/features/data/models/courses/courses_model.dart';

import '../../../domain/entities/payment/manual_payment_response_entity.dart';
import '../enrollment/enrollment_second_model.dart';

class ManualPaymentResponseModel extends ManualPaymentResponseEntity {
  String? message;
  EnrollmentSecondModel? enrollments;

  CoursesModel? formation;

  ManualPaymentResponseModel({this.message, this.enrollments, this.formation});

  ManualPaymentResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    enrollments = json['enrollment'] != null
        ? EnrollmentSecondModel.fromJson(json['enrollment'])
        : null;
    formation = json['formation'] != null
        ? CoursesModel.fromJson(json['formation'])
        : null;
  }
}
