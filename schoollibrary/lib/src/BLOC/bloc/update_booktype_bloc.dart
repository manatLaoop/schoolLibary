import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'update_booktype_event.dart';
part 'update_booktype_state.dart';

class UpdateBooktypeBloc
    extends Bloc<UpdateBooktypeEvent, UpdateBooktypeState> {
  UpdateBooktypeBloc() : super(UpdateBooktypeState()) {
    on<UpdateBooktypeEvent>((event, emit) {
      print(event.booktype);
      emit(state.copywith(bookType: event.booktype));
    });
  }
}
