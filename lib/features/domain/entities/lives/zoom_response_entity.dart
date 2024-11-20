import 'package:equatable/equatable.dart';
import 'package:school_test_online/features/domain/entities/lives/zoom_data_entity.dart';

class ZoomResponseEntity extends Equatable {
  final bool? status;
  final ZoomDataEntity? data;

  const ZoomResponseEntity({this.status, this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [status, data];
}
