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
      generatedTimestamp: fields[0] as int,
      memoTag: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      colorValue: fields[4] as int,
      imagePath: fields[5] as String,
      placeName: fields[6] as String,
      placeAddress: fields[7] as String,
      placeX: fields[8] as int,
      placeY: fields[9] as int,
      memoWidgetType: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MemosModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.generatedTimestamp)
      ..writeByte(1)
      ..write(obj.memoTag)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.colorValue)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.placeName)
      ..writeByte(7)
      ..write(obj.placeAddress)
      ..writeByte(8)
      ..write(obj.placeX)
      ..writeByte(9)
      ..write(obj.placeY)
      ..writeByte(10)
      ..write(obj.memoWidgetType);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemosModel _$MemosModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'memo_generated_on',
      'memo_tag',
      'memo_title',
      'memo_description',
      'memo_colorValue',
      'memo_image_path',
      'place_name',
      'place_address',
      'place_x',
      'place_y',
      'memo_widget_type'
    ],
  );
  return MemosModel(
    generatedTimestamp: json['memo_generated_on'] as int,
    memoTag: json['memo_tag'] as String? ?? "태그",
    title: json['memo_title'] as String,
    description: json['memo_description'] as String? ?? "",
    colorValue: json['memo_colorValue'] as int,
    imagePath: json['memo_image_path'] as String? ?? "",
    placeName: json['place_name'] as String? ?? "",
    placeAddress: json['place_address'] as String? ?? "",
    placeX: json['place_x'] as int? ?? 0,
    placeY: json['place_y'] as int? ?? 0,
    memoWidgetType: json['memo_widget_type'] as int,
  );
}

Map<String, dynamic> _$MemosModelToJson(MemosModel instance) =>
    <String, dynamic>{
      'memo_generated_on': instance.generatedTimestamp,
      'memo_tag': instance.memoTag,
      'memo_title': instance.title,
      'memo_description': instance.description,
      'memo_colorValue': instance.colorValue,
      'memo_image_path': instance.imagePath,
      'place_name': instance.placeName,
      'place_address': instance.placeAddress,
      'place_x': instance.placeX,
      'place_y': instance.placeY,
      'memo_widget_type': instance.memoWidgetType,
    };
