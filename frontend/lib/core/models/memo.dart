import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Blockit/core/constants/constants.dart';

part 'memo.g.dart';

/// Should build to generate [JsonSerializable]
///
/// `flutter pub run build_runner watch`

@HiveType(typeId: 0)
@JsonSerializable()
class MemosModel {
  MemosModel(
      {required this.generatedTimestamp,
      this.memoTag = "태그",
      required this.memo,
      this.title = "",
      required this.colorValue,
      this.imagePath = "",
      this.placeName = "",
      this.placeAddress = "",
      this.placeX = 0,
      this.placeY = 0,
      required this.memoWidgetType});

  @HiveField(0)
  @JsonKey(name: MemosModelKey.generatedTimestampKey, required: true)
  int generatedTimestamp;

  @HiveField(1)
  @JsonKey(name: MemosModelKey.tagKey, required: true)
  String memoTag;

  @HiveField(2)
  @JsonKey(name: MemosModelKey.memoKey, required: true)
  String memo;

  @HiveField(3)
  @JsonKey(name: MemosModelKey.titleKey, required: true)
  String title;

  @HiveField(4)
  @JsonKey(name: MemosModelKey.colorValueKey, required: true)
  int colorValue;

  @HiveField(5)
  @JsonKey(name: MemosModelKey.imagePathKey, required: true)
  String imagePath;

  @HiveField(6)
  @JsonKey(name: MemosModelKey.placeNameKey, required: true)
  String placeName;

  @HiveField(7)
  @JsonKey(name: MemosModelKey.placeAddressKey, required: true)
  String placeAddress;

  @HiveField(8)
  @JsonKey(name: MemosModelKey.placeXkey, required: true)
  int placeX;

  @HiveField(9)
  @JsonKey(name: MemosModelKey.placeYkey, required: true)
  int placeY;

  @HiveField(10)
  @JsonKey(name: MemosModelKey.memoWidgetTypeKey, required: true)
  int memoWidgetType;

  factory MemosModel.fromJson(Map<String, dynamic> json) =>
      _$MemosModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemosModelToJson(this);

  String getgeneratedTimeString() {
    DateTime generatedTime =
        DateTime.fromMillisecondsSinceEpoch(generatedTimestamp);

    String hourStr = generatedTime.hour < 12
        ? '오전 ${generatedTime.hour}시'
        : '오후 ${generatedTime.hour - 12}시';

    return '${generatedTime.month}월 ${generatedTime.day}일 $hourStr ${generatedTime.minute}분';
  }
}
