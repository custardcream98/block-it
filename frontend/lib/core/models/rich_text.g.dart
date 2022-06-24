// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rich_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlockitRichTextModelAdapter extends TypeAdapter<BlockitRichTextModel> {
  @override
  final int typeId = 1;

  @override
  BlockitRichTextModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlockitRichTextModel(
      type: fields[0] as BlockitRichTextType,
      text: fields[1] as String,
      textKey: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlockitRichTextModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.textKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockitRichTextModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BlockitRichTextTypeAdapter extends TypeAdapter<BlockitRichTextType> {
  @override
  final int typeId = 2;

  @override
  BlockitRichTextType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BlockitRichTextType.p;
      case 1:
        return BlockitRichTextType.h1;
      case 2:
        return BlockitRichTextType.quote;
      case 3:
        return BlockitRichTextType.bullet;
      case 4:
        return BlockitRichTextType.box;
      default:
        return BlockitRichTextType.p;
    }
  }

  @override
  void write(BinaryWriter writer, BlockitRichTextType obj) {
    switch (obj) {
      case BlockitRichTextType.p:
        writer.writeByte(0);
        break;
      case BlockitRichTextType.h1:
        writer.writeByte(1);
        break;
      case BlockitRichTextType.quote:
        writer.writeByte(2);
        break;
      case BlockitRichTextType.bullet:
        writer.writeByte(3);
        break;
      case BlockitRichTextType.box:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockitRichTextTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
