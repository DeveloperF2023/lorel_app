import 'package:equatable/equatable.dart';

class PivotFavoriteEntity extends Equatable {
  final int? userId;
  final int? offerId;
  final String? createdAt;

  const PivotFavoriteEntity({this.userId, this.offerId, this.createdAt});
  @override
  // TODO: implement props
  List<Object?> get props => [userId, offerId, createdAt];
}
