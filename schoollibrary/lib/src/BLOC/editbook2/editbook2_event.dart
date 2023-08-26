part of 'editbook2_bloc.dart';

class Editbook2Event extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Addimg extends Editbook2Event {
  String? images;
  Addimg({String? this.images});
}

class clearimg extends Editbook2Event {}
