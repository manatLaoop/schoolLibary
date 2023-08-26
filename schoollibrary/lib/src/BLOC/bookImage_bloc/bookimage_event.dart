part of 'bookimage_bloc.dart';

@immutable
abstract class BookimageEvent {}

class bookimageeventInitial extends BookimageEvent {
  bookimageeventInitial({required String image});
  String? image;
  @override
  List<Object> get props => [image!];
}

class bookimageAdd extends BookimageEvent {
  bookimageAdd({required File image});
  File? image;
  @override
  List<Object> get props => [image!];
}
