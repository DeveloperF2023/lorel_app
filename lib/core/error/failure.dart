import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message}) : super(message: message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  final String message;
  const ConnectionFailure({required this.message}) : super(message: message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  final String message;
  const DatabaseFailure({required this.message}) : super(message: message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
