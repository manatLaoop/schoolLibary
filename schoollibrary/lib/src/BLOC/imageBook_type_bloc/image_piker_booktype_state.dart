part of 'image_piker_booktype_bloc.dart';

class ImagePikerBooktypeState {
  ImagePikerBooktypeState({XFile? this.image});
  XFile? image;
  ImagePikerBooktypeState copyWith({XFile? images}) {
    // inspect(images);
    return ImagePikerBooktypeState(image: images ?? this.image);
  }

  // @override
  // List<Object> get props => [];
}
