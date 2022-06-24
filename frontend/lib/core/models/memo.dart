import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'rich_text.dart';

part 'memo.g.dart';

/// Should build to generate [JsonSerializable]
///
/// `flutter pub run build_runner watch`

/// fromJson, toJson 개발 보류
/// 추후 Backend와 상호작용이 필요할 경우 개발

@HiveType(typeId: 0)
// @JsonSerializable()
class MemosModel {
  MemosModel(
      {this.memoTag = const [],
      required this.memoHistory,
      this.title = "",
      required this.colorValue,
      this.imagePath = "",
      this.placeName = "",
      this.placeAddress = "",
      this.placeX = 0,
      this.placeY = 0,
      required this.memoWidgetType,
      required this.memoKey});
  // MemosModel.create(
  //     {
  //required DateTime created,
  //     required List<String> createdTextId,
  //     this.memoTag = const [],
  //     this.title = "",
  //     required this.colorValue,
  //     this.imagePath = "",
  //     this.placeName = "",
  //     this.placeAddress = "",
  //     this.placeX = 0,
  //     this.placeY = 0,
  //     required this.memoWidgetType,
  //     this.memoHistory = const {},
  //     this.memoId = ""}) {
  //   memoHistory = {};
  //   memoHistory[created] = [];
  //   for (String id in createdTextId) {
  //     memoHistory[created]!.add(id);
  //   }
  //   memoId = created.millisecondsSinceEpoch.toString();
  // }

  // /// Hive Box에서 Key로 이용
  // @HiveField(0)
  // // @JsonKey(name: MemosModelJsonKey.editedKey, required: true)
  // List<DateTime> edited;

  @HiveField(0)
  // @JsonKey(name: MemosModelJsonKey.tagKey, required: true)
  List<String> memoTag;

  /// [BlockitRichTextModel]의 id를 담는 곳
  ///
  /// edit시에 갱신한다.
  /// ```
  /// {
  ///   DateTime: <int>[
  ///     BlockitRichTextModel ID,
  ///     BlockitRichTextModel ID, ...
  ///   ]
  /// }
  /// ```
  @HiveField(1)
  // @JsonKey(
  //     name: MemosModelJsonKey.memoKey,
  //     required: true,
  //     fromJson: _memoFromJson,
  //     toJson: _memoToJson)
  Map<DateTime, HiveList<BlockitRichTextModel>> memoHistory;

  ///```
  /// [
  ///   [
  ///     {
  ///       isEdited: bool
  ///       created: DateTime
  ///       memo: BlockitRichTextModel
  ///     }, ...
  ///   ], ...
  /// ]
  ///```
  // @HiveField(3)
  // Map<DateTime, List<>> memoHistory;

  @HiveField(2)
  // @JsonKey(name: MemosModelJsonKey.titleKey, required: true)
  String title;

  @HiveField(3)
  // @JsonKey(name: MemosModelJsonKey.colorValueKey, required: true)
  int colorValue;

  @HiveField(4)
  // @JsonKey(name: MemosModelJsonKey.imagePathKey, required: true)
  String imagePath;

  @HiveField(5)
  // @JsonKey(name: MemosModelJsonKey.placeNameKey, required: true)
  String placeName;

  @HiveField(6)
  // @JsonKey(name: MemosModelJsonKey.placeAddressKey, required: true)
  String placeAddress;

  @HiveField(7)
  // @JsonKey(name: MemosModelJsonKey.placeXkey, required: true)
  int placeX;

  @HiveField(8)
  // @JsonKey(name: MemosModelJsonKey.placeYkey, required: true)
  int placeY;

  @HiveField(9)
  // @JsonKey(name: MemosModelJsonKey.memoWidgetTypeKey, required: true)
  int memoWidgetType;

  @HiveField(10)
  String memoKey;

  List<DateTime> get edited => memoHistory.keys.toList();
  bool get isEdited => edited.length > 1;
  DateTime get lastEdited => edited.last;
  DateTime get firstEdited => edited.first;
  //int _editedIndex(DateTime time) => edited.indexOf(time);

  // @HiveField(12)
  // @JsonKey(name: MemosModelJsonKey.editedKey, required: true)
  // List<DateTime> edited; // edited.last: 최신

  // factory MemosModel.fromJson(Map<String, dynamic> json) =>
  //     _$MemosModelFromJson(json);

  // Map<String, dynamic> toJson() => _$MemosModelToJson(this);

  // static List<List<Map<String, dynamic>>> _memoFromJson(
  //     List<Map<String, dynamic>> json) {
  //   //Box<BlockitRichTextModel> memoBox = Hive.box(HiveBoxes.memoBox);

  //   List<List<Map<String, dynamic>>> out = [];

  //   for (int i = 0; i < json.length; i++) {
  //     BlockitRichTextModel text = BlockitRichTextModel.fromJson(json[i]);

  //     // BlockitRichTextModel? textFromBox =
  //     //     textBox.get(created.millisecondsSinceEpoch.toString() + i.toString());
  //     // if (textFromBox != null) {
  //     //   if (textFromBox.compare(text)) {
  //     //     textFromBox.delete();
  //     //   }
  //     // }

  //     out.add(text);
  //   }

  //   return HiveList(memoBox, objects: out);
  // }

  // static List<List<Map<String, dynamic>>> _memoToJson(
  //     List<List<Map<String, dynamic>>> memo) {
  //   List<Map<String, dynamic>> out = [];
  //   memo.map((e) => out.add(e.toJson()));
  //   return out;
  // }

  String editedAtString() {
    DateTime time = lastEdited;
    String hourStr =
        time.hour < 12 ? '오전 ${time.hour}시' : '오후 ${time.hour - 12}시';

    return '${time.month}월 ${time.day}일 $hourStr ${time.minute}분${isEdited ? ' (수정됨)' : ''}';
  }

  List<BlockitRichTextModel> getMemo(DateTime time) =>
      memoHistory[time]!.toList();

  List<BlockitRichTextModel> getLatestMemo() => getMemo(lastEdited);

  // static MemosModel create({
  //   required DateTime created,
  //   required List<String> createdTextId,
  //   List<String> memoTag = const [],
  //   String title = "",
  //   required int colorValue,
  //   String imagePath = "",
  //   String placeName = "",
  //   String placeAddress = "",
  //   int placeX = 0,
  //   int placeY = 0,
  //   required int memoWidgetType,
  // }) {
  //   Map<DateTime, List<String>> memoHistory = {};
  //   memoHistory[created] = [];
  //   for (String id in createdTextId) {
  //     memoHistory[created]!.add(id);
  //   }
  //   String memoId = created.millisecondsSinceEpoch.toString();

  //   return MemosModel(
  //       memoTag: memoTag,
  //       title: title,
  //       colorValue: colorValue,
  //       imagePath: imagePath,
  //       placeName: placeName,
  //       placeAddress: placeAddress,
  //       placeX: placeX,
  //       placeY: placeY,
  //       memoWidgetType: memoWidgetType,
  //       memoHistory: memoHistory,
  //       memoId: memoId);
  // }
}
