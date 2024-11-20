import 'package:school_test_online/features/domain/entities/payment/rib_entity.dart';

class RibModel extends RibEntity {
  final String? rib;

  const RibModel({this.rib}) : super(rib: rib);

  factory RibModel.fromJson(Map<String, dynamic> json) {
    return RibModel(
      rib: json['rib'] as String,
    );
  }
}
