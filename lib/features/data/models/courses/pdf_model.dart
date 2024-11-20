import 'package:school_test_online/features/domain/entities/courses/pdf_entity.dart';

class PdfModel extends PdfEntity {
  String? name;
  String? url;

  PdfModel({this.name, this.url});

  PdfModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
