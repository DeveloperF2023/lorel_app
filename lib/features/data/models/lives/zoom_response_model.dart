import 'package:school_test_online/features/data/models/lives/zoom_data_model.dart';
import 'package:school_test_online/features/domain/entities/lives/zoom_response_entity.dart';

class ZoomResponseModel extends ZoomResponseEntity {
  final bool? status;
  final ZoomDataModel? data;

  ZoomResponseModel({this.status, this.data})
      : super(status: status, data: data);

  factory ZoomResponseModel.fromJson(Map<String, dynamic> json) {
    return ZoomResponseModel(
        status: json['status'],
        data:
            json['data'] != null ? ZoomDataModel.fromJson(json['data']) : null);
  }
}
