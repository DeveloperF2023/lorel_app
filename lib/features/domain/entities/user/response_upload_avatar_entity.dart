import 'package:equatable/equatable.dart';

class ResponseUploadAvatarEntity extends Equatable {
  final String? message;
  final String? url;

  const ResponseUploadAvatarEntity({this.message, this.url});
  @override
  // TODO: implement props
  List<Object?> get props => [message, url];
}
