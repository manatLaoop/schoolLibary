import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

part 'image_piker_booktype_event.dart';
part 'image_piker_booktype_state.dart';

class ImagePikerBooktypeBloc
    extends Bloc<ImagePikerBooktypeEvent, ImagePikerBooktypeState> {
  ImagePikerBooktypeBloc() : super(ImagePikerBooktypeState()) {
    List<XFile>? _mediaFileList;

    on<ImagePikerBooktypeEvent>((event, emit) {
      emit(ImagePikerBooktypeState().copyWith(images: event.imageEvent));
    });
  }
}
