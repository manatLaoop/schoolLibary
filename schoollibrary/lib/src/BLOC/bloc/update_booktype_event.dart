part of 'update_booktype_bloc.dart';

class UpdateBooktypeEvent extends Equatable {
  final String booktype;
  const UpdateBooktypeEvent({required String this.booktype});

  @override
  // TODO: implement props
  List<Object?> get props => [booktype];
}
