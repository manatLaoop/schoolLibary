import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'booktype_editbloc1_event.dart';
part 'booktype_editbloc1_state.dart';

class BooktypeEditbloc1Bloc
    extends Bloc<BooktypeEditbloc1Event, BooktypeEditbloc1State> {
  BooktypeEditbloc1Bloc() : super(BooktypeEditbloc1State()) {
    on<addimage>((event, emit) {
      emit(state.copywith(images: event.images!));
    });
    on<Clearimage>((event, emit) {
      emit(state.clearimage());
    });
  }
}
