import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../themes/theme_data.dart';
import 'provider.dart';
import '../models/rich_text.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({
    Key? key,
    required this.selectedType,
    required this.isBottom,
    // required this.onSelected
  }) : super(key: key);

  final BlockitRichTextType selectedType;
  final bool isBottom;
  // final void Function(BlockitRichTextType) onSelected;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Widget _actionButton(
      {required IconData icondata, required BlockitRichTextType type}) {
    return IconButton(
        onPressed: () {
          context.read<EditorProvider>().setType(type);
        },
        icon: Icon(icondata,
            color: widget.selectedType == type
                ? Colors.teal
                : AppThemeData.mainGrayColor));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isToolBarBottom = screenSize.height < 500 || screenSize.width < 1200;

    Widget buttonsRow = Visibility(
      visible: !(widget.isBottom ^ isToolBarBottom),
      child: Selector<EditorProvider, BlockitRichTextType>(
        selector: (context, state) => state.selectedType,
        builder: (context, selectedType, _) => Row(children: [
          _actionButton(
              icondata: Icons.format_quote_rounded,
              type: BlockitRichTextType.quote),
          _actionButton(
              icondata: Icons.format_size_rounded,
              type: BlockitRichTextType.h1),
          _actionButton(
              icondata: Icons.format_list_bulleted_rounded,
              type: BlockitRichTextType.bullet)
        ]),
      ),
    );

    if (widget.isBottom) {
      return PreferredSize(
          preferredSize: const Size.fromHeight(56), child: buttonsRow);
    } else {
      return buttonsRow;
    }
  }
}
