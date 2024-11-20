class PivotModel {
  int? userId;
  int? offerId;
  String? createdAt;

  PivotModel({this.userId, this.offerId, this.createdAt});

  PivotModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    offerId = json['offer_id'];
    createdAt = json['created_at'];
  }
}
