import 'package:equatable/equatable.dart';

class AdditionalDiplomasEntity extends Equatable {
  final String? diploma;
  final String? price;

  const AdditionalDiplomasEntity({required this.diploma, required this.price});
  @override
  // TODO: implement props
  List<Object?> get props => [diploma, price];
}
