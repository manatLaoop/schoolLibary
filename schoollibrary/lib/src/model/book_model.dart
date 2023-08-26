import 'dart:io';

import 'package:hive/hive.dart';
part 'book_model.g.dart';

@HiveType(typeId: 0)
class Bookmodel extends HiveObject {
  @HiveField(0)
  String? Booktype;
  @HiveField(1)
  String? bookname;
  @HiveField(2)
  String? bookcode;
  @HiveField(3)
  bool? status;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? dtail;
  @HiveField(6)
  String? Author;

  Bookmodel(
      {this.bookname,
      this.Booktype,
      this.bookcode,
      this.Author,
      this.image,
      this.dtail,
      this.status});
}
