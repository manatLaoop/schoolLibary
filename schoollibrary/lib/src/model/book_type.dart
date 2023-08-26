import 'dart:io';

import 'package:hive/hive.dart';
part 'book_type.g.dart';

@HiveType(typeId: 1)
class BookType extends HiveObject {
  @HiveField(0)
  String? bookname;
  @HiveField(1)
  String? booktype;
  @HiveField(2)
  String? typeImage;

  BookType(
      {required String this.bookname,
      required String this.booktype,
      required String this.typeImage});

  set text(String? text) {}
}
