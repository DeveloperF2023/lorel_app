import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/notifications/notification_entity.dart';

import '../../repositories/repository.dart';

class FetchNotificationUseCase {
  final Repository repository;

  FetchNotificationUseCase({required this.repository});
  Future<Either<Failure, List<NotificationEntity>>> callback() {
    return repository.getAllNotification();
  }
}
