part of 'editbook2_bloc.dart';

class Editbook2State {
  String? imagePath;
  Editbook2State({String? this.imagePath});
  Editbook2State copywith({String? img}) {
    return Editbook2State(imagePath: img ?? this.imagePath);
  }

  Editbook2State clearImg() {
    return Editbook2State(imagePath: null);
  }
}
