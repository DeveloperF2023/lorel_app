import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/domain/domain_entity.dart';
import '../../../../domain/use_cases/domain/fetch_domains_use_case.dart';

part 'get_domains_state.dart';

class GetDomainsCubit extends Cubit<GetDomainsState> {
  final FetchDomainsUseCase fetchDomainsUseCase;
  GetDomainsCubit({required this.fetchDomainsUseCase})
      : super(GetDomainsInitial());

  Future<void> getDomains() async {
    emit(GetDomainsLoading());
    try {
      final result = await fetchDomainsUseCase.callback();
      result.fold((l) => emit(GetDomainsFailure(message: l.message)),
          (r) => emit(GetDomainsLoaded(domains: r)));
    } on SocketException catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDomainsFailure(message: e.toString()));
    } catch (e) {
      print("this is error $e");
      print("failed registration");
      emit(GetDomainsFailure(message: e.toString()));
    }
  }
}
