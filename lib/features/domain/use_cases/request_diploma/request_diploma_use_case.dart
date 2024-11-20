import 'package:school_test_online/features/domain/entities/request_diploma/request_diploma_entity.dart';

import '../../repositories/repository.dart';

class RequestDiplomaUseCase {
  final Repository repository;

  RequestDiplomaUseCase({required this.repository});
  Future<String> callback(RequestDiplomaEntity requests, int formationId) {
    return repository.requestDiploma(requests, formationId);
  }
}
