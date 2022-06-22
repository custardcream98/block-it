import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constants/constants.dart';
import '../themes/theme_data.dart';

part 'rich_text.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class BlockitRichTextModel extends HiveObject {
  BlockitRichTextModel(
      {required this.created,
      required this.type,
      required this.text,
      required this.memoId});

  @HiveField(0)
  @JsonKey(name: BlockitRichTextModelKey.createdKey, required: true)
  DateTime created;

  @HiveField(1)
  @JsonKey(name: BlockitRichTextModelKey.typeIdKey, required: true)
  BlockitRichTextType type;

  @HiveField(2)
  @JsonKey(name: BlockitRichTextModelKey.textKey, required: true)
  String text;

  @HiveField(3)
  @JsonKey(name: BlockitRichTextModelKey.memoIdKey, required: true)
  String memoId;

  factory BlockitRichTextModel.fromJson(Map<String, dynamic> json) =>
      _$BlockitRichTextModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlockitRichTextModelToJson(this);

  bool compare(BlockitRichTextModel text) {
    return text.text == this.text && text.type == type;
  }
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
            color: AppThemeData.mainGrayColor,
            fontSize: AppThemeData.textTheme.bodySmall!.fontSize! * 0.9);
      case BlockitRichTextType.h1:
        return AppThemeData.textTheme.bodyLarge!;
      default:
        return AppThemeData.textTheme.bodySmall!;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case BlockitRichTextType.h1:
        return const EdgeInsets.fromLTRB(16, 24, 16, 8);
      case BlockitRichTextType.quote:
        return const EdgeInsets.fromLTRB(16, 16, 16, 16);
      case BlockitRichTextType.bullet:
        return const EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return const EdgeInsets.fromLTRB(16, 8, 16, 8);
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

  // int get typeId {
  //   switch (this) {
  //     case BlockitRichTextType.p:
  //       return 0;
  //     case BlockitRichTextType.h1:
  //       return 1;
  //     case BlockitRichTextType.quote:
  //       return 2;
  //     case BlockitRichTextType.bullet:
  //       return 3;
  //   }
  // }
}

// import 'package:hive/hive.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'rich_text.g.dart';

// @HiveType(typeId: 1)
// @JsonSerializable()
// class RichTextModel {
//   RichTextModel(
//       {});

//   @HiveField(0)
//   @JsonKey(name: MemosModelKey.generatedTimestampKey, required: true)
//   int generatedTimestamp;

//   factory RichTextModel.fromJson(Map<String, dynamic> json) =>
//       _$RichTextModelFromJson(json);

//   Map<String, dynamic> toJson() => _$RichTextModelToJson(this);
// }
