// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

// import '../constants/constants.dart';
import '../themes/theme_data.dart';

part 'rich_text.g.dart';

@HiveType(typeId: 1)
// @JsonSerializable()
class BlockitRichTextModel extends HiveObject {
  BlockitRichTextModel(
      {required this.type, required this.text, required this.textKey});

  //: edited = [created];

  // @HiveField(0)
  // @JsonKey(name: BlockitRichTextModelJsonKey.editedKey, required: true)
  // Map<DateTime,> edited;

  @HiveField(0)
  // @JsonKey(name: BlockitRichTextModelJsonKey.typeIdKey, required: true)
  BlockitRichTextType type;

  @HiveField(1)
  // @JsonKey(name: BlockitRichTextModelJsonKey.textKey, required: true)
  String text;

  @HiveField(2)
  // @JsonKey(name: BlockitRichTextModelJsonKey.memoIdKey, required: true)
  String textKey;

  // factory BlockitRichTextModel.fromJson(Map<String, dynamic> json) =>
  //     _$BlockitRichTextModelFromJson(json);

  // Map<String, dynamic> toJson() => _$BlockitRichTextModelToJson(this);

  // bool compare(BlockitRichTextModel text) {
  //   return listEquals(text.edited, edited) &&
  //       text.text == this.text &&
  //       text.type == type &&
  //       text.memoId == memoId;
  // }
  // BlockitRichTextType getType(DateTime time) => type[time]!;
  // String getText(DateTime time) => text[time]!;

  static String getKey(DateTime time, int index) => '$time-$index';
}

@HiveType(typeId: 2)
enum BlockitRichTextType {
  @JsonValue("p")
  @HiveField(0)
  p,
  @JsonValue("h1")
  @HiveField(1)
  h1,
  @JsonValue("quote")
  @HiveField(2)
  quote,
  @JsonValue("bullet")
  @HiveField(3)
  bullet
}

extension BlockitRichTextStyle on BlockitRichTextType {
  TextStyle get textStyle {
    switch (this) {
      case BlockitRichTextType.quote:
        return AppThemeData.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w800,
            color: AppThemeData.mainGrayColor.withAlpha(80),
            fontSize: AppThemeData.textTheme.bodySmall!.fontSize! * 1.2,
            fontStyle: FontStyle.italic);
      case BlockitRichTextType.h1:
        return AppThemeData.textTheme.bodyLarge!;
      default:
        return AppThemeData.textTheme.bodySmall!;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case BlockitRichTextType.h1:
        return const EdgeInsets.fromLTRB(2, 17, 16, 5);
      case BlockitRichTextType.quote:
        return const EdgeInsets.fromLTRB(2, 10, 16, 10);
      case BlockitRichTextType.bullet:
        return const EdgeInsets.fromLTRB(10, 2, 16, 2);
      default:
        return const EdgeInsets.fromLTRB(2, 2, 16, 2);
    }
  }

  TextAlign get align {
    switch (this) {
      case BlockitRichTextType.quote:
        return TextAlign.center;
      default:
        return TextAlign.start;
    }
  }

  String get prefix {
    switch (this) {
      case BlockitRichTextType.bullet:
        return '\u2022 ';
      default:
        return '';
    }
  }

  String get hintText {
    switch (this) {
      case BlockitRichTextType.h1:
        return "큰 글씨";
      case BlockitRichTextType.quote:
        return "인용구";
      case BlockitRichTextType.bullet:
        return "글머리 표";
      case BlockitRichTextType.p:
        return "문단";
    }
  }

  InputBorder get inputBorder {
    switch (this) {
      case BlockitRichTextType.quote:
        return OutlineInputBorder();
      default:
        return InputBorder.none;
    }
  }
}
