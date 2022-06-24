import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../themes/theme_data.dart';
import 'provider.dart';
import '../models/rich_text.dart';

class ToolBar extends StatefulWidget {
  const ToolBar({
    Key? key,
    required this.isBottom,
    // required this.onSelected
  }) : super(key: key);

  final bool isBottom;
  // final void Function(BlockitRichTextType) onSelected;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Widget _typeActionButton(
      {required IconData icondata,
      required BlockitRichTextType selectedType,
      required BlockitRichTextType type}) {
    return IconButton(
        onPressed: () {
          context.read<EditorProvider>().setType(type);
        },
        icon: Icon(icondata,
            color: selectedType == type
                ? Colors.teal
                : AppThemeData.mainGrayColor));
  }

  Widget _editorActionButton({required IconData icondata, required bool isUp}) {
    return IconButton(
        onPressed: isUp
            ? context.read<EditorProvider>().moveUp
            : context.read<EditorProvider>().moveDown,
        icon: Icon(icondata, color: AppThemeData.mainGrayColor));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isToolBarBottom = screenSize.height < 500 || screenSize.width < 1200;

    Widget buttonsRow = Visibility(
      visible: !(widget.isBottom ^ isToolBarBottom),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Selector<EditorProvider, BlockitRichTextType>(
            selector: (context, state) => state.selectedType,
            builder: (context, selectedType, _) => Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _typeActionButton(
                      icondata: Icons.format_quote_rounded,
                      selectedType: selectedType,
                      type: BlockitRichTextType.quote),
                  _typeActionButton(
                      icondata: Icons.format_size_rounded,
                      selectedType: selectedType,
                      type: BlockitRichTextType.h1),
                  _typeActionButton(
                      icondata: Icons.format_list_bulleted_rounded,
                      selectedType: selectedType,
                      type: BlockitRichTextType.bullet),
                ]),
          ),
          if (isToolBarBottom) ...[
            _editorActionButton(
                icondata: Icons.arrow_upward_rounded, isUp: true),
            _editorActionButton(
                icondata: Icons.arrow_downward_rounded, isUp: false)
          ]
        ],
      ),
    );

    if (widget.isBottom) {
      return PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Align(alignment: Alignment.centerRight, child: buttonsRow));
    } else {
      return buttonsRow;
    }
  }
}
