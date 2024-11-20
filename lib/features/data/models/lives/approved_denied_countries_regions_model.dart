class ApprovedOrDeniedCountriesOrRegionsModel {
  bool? enable;

  ApprovedOrDeniedCountriesOrRegionsModel({this.enable});

  factory ApprovedOrDeniedCountriesOrRegionsModel.fromJson(
      Map<String, dynamic> json) {
    return ApprovedOrDeniedCountriesOrRegionsModel(enable: json['enable']);
  }
}
