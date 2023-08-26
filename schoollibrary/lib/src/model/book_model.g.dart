// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmodelAdapter extends TypeAdapter<Bookmodel> {
  @override
  final int typeId = 0;

  @override
  Bookmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmodel(
      bookname: fields[1] as String?,
      Booktype: fields[0] as String?,
      bookcode: fields[2] as String?,
      Author: fields[6] as String?,
      image: fields[4] as String?,
      dtail: fields[5] as String?,
      status: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Bookmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.Booktype)
      ..writeByte(1)
      ..write(obj.bookname)
      ..writeByte(2)
      ..write(obj.bookcode)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.dtail)
      ..writeByte(6)
      ..write(obj.Author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
