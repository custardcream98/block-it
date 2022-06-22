import 'package:flutter/material.dart';

import '../../themes/theme_data.dart';
import '../../models/rich_text.dart';

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

class BlockitRichText extends StatelessWidget {
  const BlockitRichText({Key? key, required this.richText}) : super(key: key);

  final BlockitRichTextModel richText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: richText.type.padding,
      child: Text(
        richText.text,
        style: richText.type.textStyle,
        textAlign: richText.type.align,
      ),
    );
  }
}
