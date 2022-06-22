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
      created: fields[0] as DateTime,
      type: fields[1] as BlockitRichTextType,
      text: fields[2] as String,
      memoId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlockitRichTextModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.created)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.memoId);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockitRichTextModel _$BlockitRichTextModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['text_created', 'type_id', 'text', 'memoId'],
  );
  return BlockitRichTextModel(
    created: DateTime.parse(json['text_created'] as String),
    type: $enumDecode(_$BlockitRichTextTypeEnumMap, json['type_id']),
    text: json['text'] as String,
    memoId: json['memoId'] as String,
  );
}

Map<String, dynamic> _$BlockitRichTextModelToJson(
        BlockitRichTextModel instance) =>
    <String, dynamic>{
      'text_created': instance.created.toIso8601String(),
      'type_id': _$BlockitRichTextTypeEnumMap[instance.type],
      'text': instance.text,
      'memoId': instance.memoId,
    };

const _$BlockitRichTextTypeEnumMap = {
  BlockitRichTextType.p: 'p',
  BlockitRichTextType.h1: 'h1',
  BlockitRichTextType.quote: 'quote',
  BlockitRichTextType.bullet: 'bullet',
};
