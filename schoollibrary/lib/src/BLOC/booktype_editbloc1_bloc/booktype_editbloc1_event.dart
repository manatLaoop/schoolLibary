part of 'booktype_editbloc1_bloc.dart';

class BooktypeEditbloc1Event extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class addimage extends BooktypeEditbloc1Event {
  String? images;
  addimage({required String this.images});

  @override
  // TODO: implement props
  List<Object?> get props => [images];
}

class Clearimage extends BooktypeEditbloc1Event {}
