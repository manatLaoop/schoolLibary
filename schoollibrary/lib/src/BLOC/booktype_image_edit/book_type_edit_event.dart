part of 'book_type_edit_bloc.dart';

class BookTypeEditEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class BookTypeEdit extends BookTypeEditEvent {
  File? image;
  BookTypeEdit({File? this.image});
  @override
  List<Object?> get props => [image];
}

class Clearimage extends BookTypeEditEvent {}
