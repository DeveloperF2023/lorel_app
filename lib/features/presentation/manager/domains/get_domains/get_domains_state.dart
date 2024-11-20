part of 'get_domains_cubit.dart';

sealed class GetDomainsState extends Equatable {
  const GetDomainsState();
}

final class GetDomainsInitial extends GetDomainsState {
  @override
  List<Object> get props => [];
}

final class GetDomainsLoading extends GetDomainsState {
  @override
  List<Object> get props => [];
}

final class GetDomainsLoaded extends GetDomainsState {
  final List<DomainEntity> domains;

  GetDomainsLoaded({required this.domains});
  @override
  List<Object> get props => [domains];
}

final class GetDomainsFailure extends GetDomainsState {
  final String message;

  GetDomainsFailure({required this.message});
  @override
  List<Object> get props => [message];
}
