import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bookimage_event.dart';
part 'bookimage_state.dart';

class BookimageBloc extends Bloc<BookimageEvent, BookimageState> {
  BookimageBloc() : super(BookimageInitial(image: 'assets/No-Image.png')) {
    on<bookimageeventInitial>((event, emit) {
      emit(BookimageInitial().copywith(Image: event.image));
    });
    on<bookimageAdd>((event, emit) {
      emit(Bookimage().copywith(Image: event.image));
    });
  }
}
