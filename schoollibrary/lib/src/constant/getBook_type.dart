import 'package:hive/hive.dart';
import 'package:schoollibrary/src/model/book_type.dart';

class getBookType {
  static Box<BookType> gettype() => Hive.box('booktype');
}
