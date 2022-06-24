// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemosModelAdapter extends TypeAdapter<MemosModel> {
  @override
  final int typeId = 0;

  @override
  MemosModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemosModel(
      memoTag: (fields[0] as List).cast<String>(),
      memoHistory: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as DateTime, (v as HiveList).castHiveList())),
      title: fields[2] as String,
      colorValue: fields[3] as int,
      imagePath: fields[4] as String,
      placeName: fields[5] as String,
      placeAddress: fields[6] as String,
      placeX: fields[7] as int,
      placeY: fields[8] as int,
      memoWidgetType: fields[9] as int,
      memoKey: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MemosModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.memoTag)
      ..writeByte(1)
      ..write(obj.memoHistory)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.colorValue)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.placeName)
      ..writeByte(6)
      ..write(obj.placeAddress)
      ..writeByte(7)
      ..write(obj.placeX)
      ..writeByte(8)
      ..write(obj.placeY)
      ..writeByte(9)
      ..write(obj.memoWidgetType)
      ..writeByte(10)
      ..write(obj.memoKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemosModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
