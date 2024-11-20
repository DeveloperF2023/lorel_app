import 'package:dartz/dartz.dart';
import 'package:school_test_online/features/domain/entities/payment/manual_payment_response_entity.dart';

import '../../../../core/error/failure.dart';
import '../../repositories/repository.dart';

class ManualPaymentUseCase {
  final Repository repository;

  ManualPaymentUseCase({required this.repository});
  Future<Either<Failure, ManualPaymentResponseEntity>> callback(
      String formationId, String? additionalDiploma) {
    return repository.manualPayment(formationId, additionalDiploma!);
  }
}
