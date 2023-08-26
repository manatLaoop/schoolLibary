import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'editbook2_event.dart';
part 'editbook2_state.dart';

class Editbook2Bloc extends Bloc<Editbook2Event, Editbook2State> {
  Editbook2Bloc() : super(Editbook2State()) {
    on<Addimg>((event, emit) {
      emit(state.copywith(img: event.images));
    });
    on<clearimg>((event, emit) {
      emit(state.clearImg());
    });
  }
}
