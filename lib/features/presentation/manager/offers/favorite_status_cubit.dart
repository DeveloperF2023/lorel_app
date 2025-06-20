import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_status_state.dart';

class FavoriteStatusCubit extends Cubit<bool> {
  FavoriteStatusCubit(super.initialStatus);

  void updateStatus(bool newStatus) => emit(newStatus);
}
