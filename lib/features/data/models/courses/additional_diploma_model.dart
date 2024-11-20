import 'package:school_test_online/features/domain/entities/courses/additional_diplomas_entity.dart';

class AdditionalDiplomasModel extends AdditionalDiplomasEntity {
  String? diploma;
  String? price;

  AdditionalDiplomasModel({this.diploma, this.price})
      : super(diploma: diploma, price: price);

  factory AdditionalDiplomasModel.fromJson(Map<String, dynamic> json) {
    return AdditionalDiplomasModel(
      diploma: json['diploma'],
      price: json['price'],
    );
  }
}
