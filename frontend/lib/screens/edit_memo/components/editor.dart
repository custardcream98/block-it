import 'package:flutter/material.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:Blockit/core/themes/themeData.dart';

class Editor extends StatefulWidget {
  Editor({Key? key, required this.controller, required this.setFocusNode})
      : super(key: key);

  TextEditingController controller;
  Function(FocusNode) setFocusNode;

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  String _liveText = "";
  final FocusNode _editorFocus = FocusNode();

  @override
  void initState() {
    widget.setFocusNode(_editorFocus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {
        _liveText = widget.controller.text;
      });
    });

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        focusNode: _editorFocus,
                        autofocus: true,
                        expands: true,
                        autocorrect: false,
                        maxLines: null,
                        minLines: null,
                        controller: widget.controller,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                            hintText: '메모',
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                            focusColor: AppThemeData.mainGrayColor,
                            hoverColor: AppThemeData.mainGrayColor,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppThemeData.mainGrayColor,
                                    width: 0.8)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppThemeData.mainGrayColor,
                                    width: 0.8))),
                        keyboardType: TextInputType.multiline,
                        cursorColor: AppThemeData.mainGrayColor,
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: Markdown(
                        padding: EdgeInsets.zero,
                        styleSheet: AppThemeData.markdownStyleSheet,
                        extensionSet: md.ExtensionSet(
                            md.ExtensionSet.gitHubWeb.blockSyntaxes,
                            ModeifiedMarkDownSyntaxes.inlineSyntaxes),
                        data: _liveText.replaceAll('\n', '\n\n'),
                      ))
                ],
              )),
          Positioned(
              right: 0,
              top: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: EditorActions.actions(
                    controller: widget.controller,
                    setFocusToEditor: () => _editorFocus.requestFocus()),
              ))
        ],
      ),
    );
  }
}

class ModeifiedMarkDownSyntaxes {
  static List<md.InlineSyntax> inlineSyntaxes = [
    md.EmojiSyntax(),
    ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
  ];
}

class EditorActions {
  late final TextEditingController _controller;
  late final Function _setFocusToEditor;

  EditorActions._(this._controller, this._setFocusToEditor);

  static List<Widget> actions(
      {required TextEditingController controller,
      required Function setFocusToEditor}) {
    EditorActions action = EditorActions._(controller, setFocusToEditor);
    return [
      _actionButton(
          action: action,
          syntax: EditorSyntax.boldSyntax,
          syntaxHint: EditorSyntax.boldSyntaxHint,
          icondata: Icons.format_bold_rounded),
      _actionButton(
          action: action,
          syntax: EditorSyntax.italicSyntax,
          syntaxHint: EditorSyntax.italicSyntaxHint,
          icondata: Icons.format_italic_rounded),
      _actionButton(
          action: action,
          syntax: EditorSyntax.quoteSyntax,
          icondata: Icons.format_quote_rounded),
      _actionButton(
          action: action,
          syntax: EditorSyntax.headerSyntax,
          icondata: Icons.format_size_rounded),
    ];
  }

  static Widget _actionButton({
    required EditorActions action,
    required String syntax,
    String syntaxHint = "",
    required IconData icondata,
  }) {
    return IconButton(
        onPressed: () {
          action._setFocusToEditor();
          EditorSyntax.syntax(action._controller, syntax, syntaxHint);
        },
        icon: Icon(icondata, color: AppThemeData.mainGrayColor));
  }
}

class EditorSyntax {
  static void syntax(
      TextEditingController controller, String syntax, String syntaxHint) {
    EditorCursor cursor = EditorCursor(controller: controller);

    if (cursor.text.isNotEmpty) {
      if (_syntaxDelete(cursor, syntax)) return;
    }
    switch (syntax) {
      case boldSyntax:
      case italicSyntax:
        _syntaxWrapping(cursor, syntax, syntaxHint);
        break;
      case quoteSyntax:
      case headerSyntax:
        _syntaxOnFront(cursor, syntax);
    }
  }

  static _syntaxWrapping(
      EditorCursor cursor, String syntax, String syntaxHint) {
    if (cursor.isCollapsed) {
      String newValue = cursor.textBefore() +
          syntax +
          syntaxHint +
          syntax +
          cursor.textAfter();
      cursor.controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection(
              baseOffset: newValue.length -
                  syntax.length -
                  syntaxHint.length -
                  cursor.textAfter().length,
              extentOffset:
                  newValue.length - syntax.length - cursor.textAfter().length));
      return;
    }

    String selectedString = cursor
        .selectedString()
        .replaceAll(RegExp(r'\n| \n'), '$syntax \n$syntax');

    String newValue = cursor.textBefore() +
        (selectedString[0] == ' ' ? ' ' : '') +
        syntax +
        selectedString.trim() +
        syntax +
        (selectedString[selectedString.length - 1] == ' ' ? ' ' : '') +
        cursor.textAfter();
    cursor.controller.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.fromPosition(
            TextPosition(offset: newValue.length - cursor.textAfter().length)));
  }

  static _syntaxOnFront(EditorCursor cursor, String syntax) {
    String newValue = "";

    if (cursor.textBefore().isEmpty) {
      newValue = syntax;
    } else {
      for (int i = cursor.textBefore().length - 1; i >= 0; i--) {
        if (cursor.textBefore()[i] == '\n') {
          newValue = cursor.textBefore().replaceRange(i, i + 1, "\n$syntax");
          break;
        } else if (i == 0) {
          newValue = "$syntax${cursor.textBefore().trimLeft()}";
        }
      }
    }

    final String pattern1 = '$syntax{1,5}[^ ]';
    final String pattern2 = '[^$syntax{1,5}]';

    if (cursor.isCollapsed) {
      newValue += cursor.textAfter().trimLeft();
      newValue = newValue.replaceAllMapped(RegExp(pattern1), (match) {
        if (match.group(0) ==
            match.group(0)!.replaceAll(RegExp(pattern2), '')) {
          return match.group(0)!;
        } else {
          return '${match.group(0)!.replaceAll(RegExp(pattern2), '')} ${match.group(0)!.replaceAll(syntax, '')}';
        }
      });

      cursor.controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.fromPosition(
              TextPosition(offset: cursor.startIndex + syntax.length + 1)));
      return;
    }

    newValue = (newValue +
            cursor.selectedString().replaceAll(RegExp(r'\n'), '\n$syntax') +
            cursor.textAfter())
        .replaceAllMapped(RegExp(pattern1), (match) {
      if (match.group(0) == match.group(0)!.replaceAll(RegExp(pattern2), '')) {
        return match.group(0)!;
      } else {
        return '${match.group(0)!.replaceAll(RegExp(pattern2), '')} ${match.group(0)!.replaceAll(syntax, '')}';
      }
    });

    cursor.controller.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.fromPosition(
            TextPosition(offset: newValue.length - cursor.textAfter().length)));
  }

  static bool _syntaxDelete(EditorCursor cursor, String syntax) {
    if ((cursor.text.length - cursor.endIndex - syntax.length >= 0) &&
        (cursor.startIndex - syntax.length >= 0)) {
      switch (syntax) {
        case boldSyntax:
        case italicSyntax:
          return _syntaxDeleteWrapping(cursor, syntax);
        case quoteSyntax:
        case headerSyntax:
          return _syntaxDeleteOnFront(cursor, syntax);
        default:
          return false;
      }
    }
    return false;
  }

  static bool _syntaxDeleteWrapping(EditorCursor cursor, String syntax) {
    String syntaxBefore = cursor.text
        .substring(cursor.startIndex - syntax.length, cursor.startIndex);
    String syntaxAfter =
        cursor.text.substring(cursor.endIndex, cursor.endIndex + syntax.length);
    if (syntaxBefore == syntax && syntaxAfter == syntax) {
      String newValue = cursor
              .textBefore()
              .substring(0, cursor.textBefore().length - syntax.length) +
          cursor.selectedString() +
          cursor.textAfter().substring(syntax.length);
      cursor.controller.value = TextEditingValue(
          text: newValue,
          selection: TextSelection.fromPosition(
              TextPosition(offset: cursor.endIndex - syntax.length)));
      return true;
    }
    return false;
  }

  static bool _syntaxDeleteOnFront(EditorCursor cursor, String syntax) {
    return false;
  }

  static const String boldSyntax = '**';
  static const String boldSyntaxHint = '볼드체';
  static const String italicSyntax = '*';
  static const String italicSyntaxHint = '이텔릭체';
  static const String quoteSyntax = '>';
  static const String headerSyntax = '#';
}

class EditorCursor {
  EditorCursor({required this.controller})
      : text = controller.text,
        isCollapsed = controller.selection.isCollapsed,
        startIndex =
            controller.selection.baseOffset < controller.selection.extentOffset
                ? controller.selection.baseOffset
                : controller.selection.extentOffset,
        endIndex =
            controller.selection.baseOffset >= controller.selection.extentOffset
                ? controller.selection.baseOffset
                : controller.selection.extentOffset;
  String text;
  bool isCollapsed;
  int startIndex;
  int endIndex;

  TextEditingController controller;

  String textBefore() => text.substring(0, startIndex);
  String textAfter() => text.substring(endIndex);
  String selectedString() => text.substring(startIndex, endIndex);
  //List<String> textLinebreakList() => text.split('\n');
}
