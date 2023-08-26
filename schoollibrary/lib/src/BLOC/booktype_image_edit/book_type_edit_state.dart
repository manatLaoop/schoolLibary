part of 'book_type_edit_bloc.dart';

class BookTypeEditState {
  File? image;
  BookTypeEditState({File? this.image});

  BookTypeEditState coppyWith({File? images}) {
    return BookTypeEditState(image: images);
  }

  BookTypeEditState clearimage({File? images}) {
    return BookTypeEditState(image: null);
  }
}
