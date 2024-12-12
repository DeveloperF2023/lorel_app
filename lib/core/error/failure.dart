import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  @override
  final String serverMessage;
  const ServerFailure({required this.serverMessage})
      : super(message: serverMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [serverMessage];
}

class ConnectionFailure extends Failure {
  @override
  final String connectionMessage;
  const ConnectionFailure({required this.connectionMessage})
      : super(message: connectionMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [connectionMessage];
}

class DatabaseFailure extends Failure {
  @override
  final String databaseMessage;
  const DatabaseFailure({required this.databaseMessage})
      : super(message: databaseMessage);
  @override
  // TODO: implement props
  List<Object?> get props => [databaseMessage];
}
