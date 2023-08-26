part of 'booktype_editbloc1_bloc.dart';

class BooktypeEditbloc1State {
  String? image;
  BooktypeEditbloc1State({String? this.image});

  BooktypeEditbloc1State copywith({required String images}) {
    return BooktypeEditbloc1State(image: images);
  }

  BooktypeEditbloc1State clearimage() {
    return BooktypeEditbloc1State(image: null);
  }
}
