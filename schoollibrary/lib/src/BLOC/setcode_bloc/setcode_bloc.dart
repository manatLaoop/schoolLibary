import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setcode_event.dart';
part 'setcode_state.dart';

class SetcodeBloc extends Bloc<SetcodeEvent, SetcodeState> {
  SetcodeBloc() : super(SetcodeState()) {
    on<SetcodeEvent>((event, emit) {
      emit(state.copywith(code: event.code));
    });
  }
}
