part of 'bookimage_bloc.dart';

abstract class BookimageState extends Equatable {}

class BookimageInitial extends BookimageState {
  BookimageInitial({String? this.image});
  String? image;
  BookimageState copywith({String? Image}) {
    return BookimageInitial(image: Image ?? this.image);
  }

  @override
  List<Object> get props => [image!];
}

class Bookimage extends BookimageState {
  Bookimage({this.image});
  File? image;
  BookimageState copywith({File? Image}) {
    return Bookimage(image: Image ?? this.image);
  }

  @override
  List<Object> get props => [image!];
}
