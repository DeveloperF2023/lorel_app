import 'package:dartz/dartz.dart';
import 'package:school_test_online/core/error/failure.dart';
import 'package:school_test_online/features/domain/entities/user/response_upload_avatar_entity.dart';

import '../../repositories/repository.dart';

class UploadAvatarUseCase {
  final Repository repository;

  UploadAvatarUseCase({required this.repository});
  Future<Either<Failure, ResponseUploadAvatarEntity>> callback(String avatar) {
    return repository.uploadAvatar(avatar);
  }
}
