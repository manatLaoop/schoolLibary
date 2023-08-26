import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'snackbar_bloc_event.dart';
part 'snackbar_bloc_state.dart';

class SnackbarBlocBloc extends Bloc<SnackbarBlocEvent, SnackbarBlocState> {
  SnackbarBlocBloc() : super(SnackbarBlocState(status: false)) {
    on<statusTrue>((event, emit) {
      emit(state.copyWith(Status: true));
    });
    on<statusFalse>((event, emit) {
      emit(state.copyWith(Status: false));
    });
  }
}
