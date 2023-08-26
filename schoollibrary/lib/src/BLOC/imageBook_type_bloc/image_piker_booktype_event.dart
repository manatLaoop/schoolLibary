part of 'image_piker_booktype_bloc.dart';

class ImagePikerBooktypeEvent extends Equatable {
  ImagePikerBooktypeEvent({XFile? this.imageEvent});
  XFile? imageEvent;
  @override
  List<Object> get props => [imageEvent!];
}

class resetImage extends ImagePikerBooktypeEvent {}
