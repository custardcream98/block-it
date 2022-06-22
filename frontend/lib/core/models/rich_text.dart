import 'package:flutter/material.dart';

import '../themes/theme_data.dart';

enum BlockitRichTextType { h1, p, quote, bullet }

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
}

class BlockitRichTextField extends StatelessWidget {
  const BlockitRichTextField(
      {Key? key,
      required this.type,
      required this.controller,
      required this.focusNode})
      : super(key: key);

  final BlockitRichTextType type;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: AppThemeData.mainGrayColor,
        textAlign: type.align,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: type.prefix,
            prefixStyle: type.textStyle,
            isDense: true,
            contentPadding: type.padding),
        style: type.textStyle);
  }
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
