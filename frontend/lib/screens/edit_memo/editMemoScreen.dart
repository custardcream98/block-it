import 'dart:math';

import 'package:flutter/material.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:Blockit/core/models/memo.dart';
import 'package:Blockit/core/constants/constants.dart';
import 'package:Blockit/core/constants/infoStrings.dart';
import 'package:Blockit/core/themes/colorPalette.dart';
import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/core/components/selectColor.dart';

import 'package:Blockit/screens/home/homeScreen.dart';
import 'package:Blockit/screens/edit_memo/components/editor.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  final TextEditingController _memoController = TextEditingController();
  final TextEditingController _memoTitleController = TextEditingController();
  late FocusNode _editorFocusNode;

  int colorVal =
      ColorPalette.colors[Random().nextInt(ColorPalette.colors.length)].value;

  bool _isColorSelected = false;

  Widget _colorSelectIcon() {
    if (!_isColorSelected) {
      return _imageIcon(Assets.paletteIconDir);
    } else {
      return Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: AppThemeData.defaultBoxShadow,
            color: Color(colorVal)),
      );
    }
  }

  Widget _imageIcon(String imageDir) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: AppThemeData.defaultBoxShadow),
      child: Image(
          width: 25,
          height: 25,
          fit: BoxFit.contain,
          image: AssetImage(imageDir)),
    );
  }

  void _setFocusNode(FocusNode editorFocusNode) {
    _editorFocusNode = editorFocusNode;
  }

  void _setFocusToEditor() {
    _editorFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, // disable keyboard resize
        backgroundColor: AppThemeData.mainBackgroundWhite,
        appBar: Components.appBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppThemeData.mainGrayColor,
                )),
            title: TextField(
              controller: _memoTitleController,
              autofocus: false,
              autocorrect: false,
              maxLines: 1,
              minLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                  hintText: '제목',
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  focusColor: AppThemeData.mainGrayColor,
                  hoverColor: AppThemeData.mainGrayColor,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
              keyboardType: TextInputType.text,
              cursorColor: AppThemeData.mainGrayColor,
              onEditingComplete: () => _editorFocusNode.requestFocus(),
              onSubmitted: (input) => _editorFocusNode.requestFocus(),
            ),
            actions: [
              // ...EditorActions.actions(
              //     controller: _memoController,
              //     setFocusToEditor: _setFocusToEditor),
              ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              //contentPadding: EdgeInsets.all(20),
                              scrollable: true,
                              backgroundColor: AppThemeData.mainBackgroundWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      AppThemeData.defaultBoxBorderRadius),
                              content: MarkdownBody(
                                listItemCrossAxisAlignment:
                                    MarkdownListItemCrossAxisAlignment.start,
                                styleSheet: AppThemeData.markdownStyleSheet,
                                extensionSet: md.ExtensionSet(
                                    md.ExtensionSet.gitHubWeb.blockSyntaxes,
                                    ModeifiedMarkDownSyntaxes.inlineSyntaxes),
                                data: InfoString.howToUse,
                              ));
                        });
                  },
                  style: AppThemeData.transparentElevatedButtonStyle,
                  child: _imageIcon(Assets.markdownIconDir)),
              ElevatedButton(
                  onPressed: () async {
                    int? newColorVal = await ColorSelector.colorSelectDialog(
                      context: context,
                    );
                    if (newColorVal != null) {
                      setState(() {
                        colorVal = newColorVal;
                        _isColorSelected = true;
                      });
                    }
                  },
                  style: AppThemeData.transparentElevatedButtonStyle,
                  child: _colorSelectIcon()),
              IconButton(
                  onPressed: () async {
                    if (_memoController.text.isNotEmpty) {
                      final Box<MemosModel> _memoBox =
                          await Hive.box<MemosModel>(HiveBoxes.memoBox);
                      int now = DateTime.now().millisecondsSinceEpoch;
                      _memoBox.put(
                          now.toString(),
                          MemosModel(
                              colorValue: colorVal,
                              generatedTimestamp: now,
                              title: _memoTitleController.text,
                              memo: _memoController.text.replaceAll(
                                  RegExp(r'(\n)(?!(>|([0-9]+\.\s)|(\*\s)))'),
                                  '\n\n'),
                              memoWidgetType: MemoWidgetType.labelLong));

                      if (!mounted) return;

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  },
                  icon: Icon(
                    Icons.save,
                    color: AppThemeData.mainGrayColor,
                  ))
            ]),
        body: Editor(
          controller: _memoController,
          setFocusNode: _setFocusNode,
        ));
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }
}
