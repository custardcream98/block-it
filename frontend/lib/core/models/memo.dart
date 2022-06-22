import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constants/constants.dart';
import 'rich_text.dart';

part 'memo.g.dart';

/// Should build to generate [JsonSerializable]
///
/// `flutter pub run build_runner watch`

@HiveType(typeId: 0)
@JsonSerializable()
class MemosModel {
  MemosModel(
      {required this.created,
      this.memoTag = const [],
      required this.memo,
      this.title = "",
      required this.colorValue,
      this.imagePath = "",
      this.placeName = "",
      this.placeAddress = "",
      this.placeX = 0,
      this.placeY = 0,
      required this.memoWidgetType,
      this.isEdited = false});

  @HiveField(0)
  @JsonKey(name: MemosModelKey.createdKey, required: true)
  DateTime created;

  @HiveField(1)
  @JsonKey(name: MemosModelKey.tagKey, required: true)
  List<String> memoTag;

  @HiveField(2)
  @JsonKey(
      name: MemosModelKey.memoKey,
      required: true,
      fromJson: _memoFromJson,
      toJson: _memoToJson)
  HiveList<BlockitRichTextModel> memo;

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

  @HiveField(11)
  bool isEdited;

  @HiveField(12)
  @JsonKey(name: MemosModelKey.editedKey, required: false)
  DateTime? edited;

  factory MemosModel.fromJson(Map<String, dynamic> json) =>
      _$MemosModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemosModelToJson(this);

  static HiveList<BlockitRichTextModel> _memoFromJson(
      List<Map<String, dynamic>> json) {
    Box<BlockitRichTextModel> memoBox = Hive.box(HiveBoxes.memoBox);

    List<BlockitRichTextModel> out = [];

    for (int i = 0; i < json.length; i++) {
      BlockitRichTextModel text = BlockitRichTextModel.fromJson(json[i]);

      // BlockitRichTextModel? textFromBox =
      //     textBox.get(created.millisecondsSinceEpoch.toString() + i.toString());
      // if (textFromBox != null) {
      //   if (textFromBox.compare(text)) {
      //     textFromBox.delete();
      //   }
      // }

      out.add(text);
    }

    return HiveList(memoBox, objects: out);
  }

  static List<Map<String, dynamic>> _memoToJson(
      HiveList<BlockitRichTextModel> memo) {
    List<Map<String, dynamic>> out = [];
    memo.map((e) => out.add(e.toJson()));
    return out;
  }

  String createdAtString() {
    DateTime time = (isEdited ? edited! : created);
    String hourStr =
        time.hour < 12 ? '오전 ${time.hour}시' : '오후 ${time.hour - 12}시';

    return '${time.month}월 ${time.day}일 $hourStr ${time.minute}분${isEdited ? ' (수정됨)' : ''}';
  }

  // String getMemeo
}
