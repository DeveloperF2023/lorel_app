import 'package:equatable/equatable.dart';

class PdfEntity extends Equatable {
  final String? name;
  final String? url;

  const PdfEntity({this.name, this.url});
  @override
  // TODO: implement props
  List<Object?> get props => [name, url];
}
