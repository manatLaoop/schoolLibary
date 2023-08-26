// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookTypeAdapter extends TypeAdapter<BookType> {
  @override
  final int typeId = 1;

  @override
  BookType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookType(
      bookname: fields[0] as String,
      booktype: fields[1] as String,
      typeImage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bookname)
      ..writeByte(1)
      ..write(obj.booktype)
      ..writeByte(2)
      ..write(obj.typeImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
