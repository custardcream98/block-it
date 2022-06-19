import 'dart:math';

import 'package:flutter/material.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:Blockit/core/models/memo.dart';
import 'package:Blockit/core/constants/constants.dart';
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
  final TextEditingController _memoController = TextEditingController(
      // text:
      //     "# h1 \n## h2 \n### h3 \n#### h4\n`code block`\nbold **bold**\nplane text\nnext line"
      );
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
            ),
            actions: [
              // ...EditorActions.actions(
              //     controller: _memoController,
              //     setFocusToEditor: _setFocusToEditor),
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
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
                                styleSheet: AppThemeData.markdownStyleSheet,
                                extensionSet: md.ExtensionSet(
                                    md.ExtensionSet.gitHubWeb.blockSyntaxes,
                                    ModeifiedMarkDownSyntaxes.inlineSyntaxes),
                                data: '''
> block it은 마크다운 입력을 지원합니다.

--------

### 사용법

마크다운을 이용하면 손가락을 키보드에서 떼지 않고도 글을 예쁘게 쓸 수 있습니다.

몇가지 간단한 심볼만 입력하면 됩니다.

#### 볼드체

```
**이렇게 쓰면 볼드체가 됩니다.**
```

**이렇게 쓰면 볼드체가 됩니다.**

#### 이텔릭체

```
*이렇게 쓰면 이텔릭체가 됩니다.*
```

*이렇게 쓰면 이텔릭체가 됩니다.*

#### 이텔릭 볼드체

```
***이렇게 쓰면 이텔릭 볼드체가 됩니다.***
```

***이렇게 쓰면 이텔릭 볼드체가 됩니다.***

이런 식으로 여러 문법을 중첩해서도 사용할 수 있습니다.

#### 큰 글씨

다섯 가지의 큰 글씨가 있습니다.

```
# 큰 글씨 1
## 큰 글씨 2
### 큰 글씨 3
#### 큰 글씨 4
##### 큰 글씨 5
```

# 큰 글씨 1
## 큰 글씨 2
### 큰 글씨 3
#### 큰 글씨 4
##### 큰 글씨 5

> 태그를 입력하고 한 칸을 꼭 띄워주세요.

''',
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
                              memo:
                                  _memoController.text.replaceAll('\n', '\n\n'),
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
