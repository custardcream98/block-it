import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:Blockit/core/models/memo.dart';
import 'package:Blockit/core/constants/constants.dart';
import 'package:Blockit/core/themes/colorPalette.dart';
import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/core/components/selectColor.dart';

import 'package:Blockit/screens/home/homeScreen.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  TextEditingController memoTitleController = TextEditingController();

  int colorVal =
      ColorPalette.colors[Random().nextInt(ColorPalette.colors.length)].value;

  bool _isColorSelected = false;

  Widget _colorSelectIcon() {
    if (!_isColorSelected) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: AppThemeData.defaultBoxShadow),
        child: const Image(
            width: 25,
            height: 25,
            fit: BoxFit.fill,
            image: AssetImage('lib/core/assets/icons/palette.png')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.mainBackgroundWhite,
      appBar: Components.appBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppThemeData.mainGrayColor,
              )),
          actions: [
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
                  if (memoTitleController.text.isNotEmpty) {
                    final Box<MemosModel> _memoBox =
                        await Hive.box<MemosModel>(HiveBoxes.memoBox);
                    int now = DateTime.now().millisecondsSinceEpoch;
                    _memoBox.put(
                        now.toString(),
                        MemosModel(
                            colorValue: colorVal,
                            generatedTimestamp: now,
                            title: memoTitleController.text,
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
          ]
          // title: TextField(
          //   controller: memoTitleController,
          //   decoration: InputDecoration(
          //       hintText: '제목',
          //       labelStyle: Theme.of(context).textTheme.titleMedium,
          //       focusColor: AppThemeData.mainGrayColor,
          //       hoverColor: AppThemeData.mainGrayColor,
          //       enabledBorder: UnderlineInputBorder(
          //           borderSide: BorderSide(
          //               color: AppThemeData.mainGrayColor, width: 0.8)),
          //       focusedBorder: UnderlineInputBorder(
          //           borderSide: BorderSide(
          //               color: AppThemeData.mainGrayColor, width: 2))),
          //   keyboardType: TextInputType.text,
          //   cursorColor: AppThemeData.mainGrayColor,
          // )),
          ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 80,
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              autofocus: true,
              expands: true,
              autocorrect: false,
              maxLines: null,
              minLines: null,
              controller: memoTitleController,
              decoration: InputDecoration(
                  hintText: '메모',
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  focusColor: AppThemeData.mainGrayColor,
                  hoverColor: AppThemeData.mainGrayColor,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppThemeData.mainGrayColor, width: 0.8)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppThemeData.mainGrayColor, width: 2))),
              keyboardType: TextInputType.multiline,
              cursorColor: AppThemeData.mainGrayColor,
            )),
      ),
    );
  }

  @override
  void dispose() {
    memoTitleController.dispose();
    super.dispose();
  }
}
