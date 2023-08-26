import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoollibrary/src/model/book_model.dart';

class Book {
  static Box<Bookmodel> boxes() => Hive.box('book');
}
