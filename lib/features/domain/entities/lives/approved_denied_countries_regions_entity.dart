import 'package:equatable/equatable.dart';

class ApprovedOrDeniedCountriesOrRegions extends Equatable {
  final bool? enable;

  const ApprovedOrDeniedCountriesOrRegions({required this.enable});
  @override
  // TODO: implement props
  List<Object?> get props => [enable];
}
