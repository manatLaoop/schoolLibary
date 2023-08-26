import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_type_edit_event.dart';
part 'book_type_edit_state.dart';

class BookTypeEditBloc extends Bloc<BookTypeEditEvent, BookTypeEditState> {
  BookTypeEditBloc() : super(BookTypeEditState()) {
    on<BookTypeEdit>((event, emit) {
      emit(state.coppyWith(images: event.image));
    });
    on<Clearimage>((event, emit) {
      emit(state.clearimage());
    });
  }
}
