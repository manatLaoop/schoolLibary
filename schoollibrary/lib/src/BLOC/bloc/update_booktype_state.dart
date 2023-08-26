part of 'update_booktype_bloc.dart';

class UpdateBooktypeState extends Equatable {
  String? booktype;
  UpdateBooktypeState({String? this.booktype});
  UpdateBooktypeState copywith({String? bookType}) {
    print(bookType);
    return UpdateBooktypeState(booktype: bookType ?? this.booktype);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [booktype];
}
