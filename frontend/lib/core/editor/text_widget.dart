import 'package:flutter/material.dart';

import '../themes/theme_data.dart';
import '../models/rich_text.dart';

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
    if (type == BlockitRichTextType.box) {
      return BlockitBoxType(
        child: TextField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: AppThemeData.mainGrayColor,
            textAlign: type.align,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 4.1, bottom: 4.1),
              hintText: type.hintText,
              border: InputBorder.none,
              prefixText: type.prefix,
              prefixStyle: type.textStyle,
              isDense: true,
            ),
            style: type.textStyle),
      );
    }
    return Padding(
      padding: type.padding,
      child: TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          cursorColor: AppThemeData.mainGrayColor,
          textAlign: type.align,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 4.1, bottom: 4.1),
            hintText: type.hintText,
            border: InputBorder.none,
            prefixText: type.prefix,
            prefixStyle: type.textStyle,
            isDense: true,
          ),
          style: type.textStyle),
    );
  }
}

class BlockitRichText extends StatelessWidget {
  const BlockitRichText({Key? key, required this.richText}) : super(key: key);

  final BlockitRichTextModel richText;

  @override
  Widget build(BuildContext context) {
    if (richText.type == BlockitRichTextType.box) {
      return BlockitBoxType(
        child: Text(
          richText.type.prefix + richText.text,
          style: richText.type.textStyle,
          textAlign: richText.type.align,
        ),
      );
    }
    return Padding(
      padding: richText.type.padding,
      child: Text(
        richText.type.prefix + richText.text,
        style: richText.type.textStyle,
        textAlign: richText.type.align,
      ),
    );
  }
}

class BlockitBoxType extends StatelessWidget {
  const BlockitBoxType({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 223, 222, 222),
            child: Padding(
                padding: BlockitRichTextType.box.padding, child: child)),
        Positioned.fill(
          child: Row(
            children: [
              Container(
                height: double.maxFinite,
                width: 5,
                color: const Color.fromARGB(255, 94, 94, 94),
              ),
              const Expanded(child: SizedBox.shrink()),
            ],
          ),
        )
      ],
    );
  }
}
