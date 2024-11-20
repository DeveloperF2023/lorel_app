import 'package:equatable/equatable.dart';

class RibEntity extends Equatable {
  final String? rib;

  const RibEntity({required this.rib});
  @override
  // TODO: implement props
  List<Object?> get props => [rib];
}
