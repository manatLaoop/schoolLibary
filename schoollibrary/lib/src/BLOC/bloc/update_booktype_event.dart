part of 'update_booktype_bloc.dart';

class UpdateBooktypeEvent extends Equatable {
  String? booktype;
  UpdateBooktypeEvent({required String booktype});
 
  @override
  // TODO: implement props
  List<Object?> get props => [booktype];
}
