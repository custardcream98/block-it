import 'dart:math';

import 'package:block_it/core/editor/provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../core/components/components.dart';
import '../../core/components/select_color.dart';
import '../../core/constants/constants.dart';
import '../../core/editor/editor.dart';
import '../../core/editor/toolbar.dart';
import '../../core/models/memo.dart';
import '../../core/models/rich_text.dart';
import '../../core/themes/color_palette.dart';
import '../../core/themes/theme_data.dart';
import '../home/home_screen.dart';

class EditMemoScreen extends StatefulWidget {
  const EditMemoScreen({Key? key, this.isEdit = false, this.memoModelForEdit})
      : super(key: key);

  final bool isEdit;
  final MemosModel? memoModelForEdit;

  @override
  State<EditMemoScreen> createState() => _EditMemoScreenState();
}

class _EditMemoScreenState extends State<EditMemoScreen> {
  final FocusNode _editorFocusNode = FocusNode();
  final TextEditingController _memoTitleController = TextEditingController();
  int _colorVal =
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
            color: Color(_colorVal)),
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

  void _loadMemo() {
    setState(() {
      _memoTitleController.text = widget.memoModelForEdit!.title;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isEdit) {
        _loadMemo();
      }
    });
  }

  @override
  void dispose() {
    _memoTitleController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EditorProvider(
            isEdit: widget.isEdit,
            memosModel: widget.isEdit ? widget.memoModelForEdit! : null),
        builder: (context, _) {
          return Scaffold(
              // resizeToAvoidBottomInset: false, // disable keyboard resize
              backgroundColor: AppThemeData.mainBackgroundWhite,
              appBar: Components.appBar(
                  leading: IconButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          )),
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
                    const ToolBar(isBottom: false),
                    ElevatedButton(
                        onPressed: () async {
                          int? newColorVal =
                              await ColorSelector.colorSelectDialog(
                            context: context,
                          );
                          if (newColorVal != null) {
                            setState(() {
                              _colorVal = newColorVal;
                              _isColorSelected = true;
                            });
                          }
                        },
                        style: AppThemeData.transparentElevatedButtonStyle,
                        child: _colorSelectIcon()),
                    SaveButton(
                      titleController: _memoTitleController,
                      colorVal: _colorVal,
                      isEdit: widget.isEdit,
                      memosModel:
                          widget.isEdit ? widget.memoModelForEdit : null,
                    )
                  ]),
              body: Column(
                children: const [
                  Expanded(
                    child: Editor(),
                  ),
                  ToolBar(isBottom: true)
                ],
              ));
        });
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton(
      {Key? key,
      required this.isEdit,
      required this.titleController,
      required this.colorVal,
      this.memosModel})
      : super(key: key);

  final bool isEdit;
  final TextEditingController titleController;
  final int colorVal;
  final MemosModel? memosModel;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  Future _editOrSave(EditorProvider state, DateTime now) async {
    final Box<MemosModel> memoBox = Hive.box<MemosModel>(HiveBoxes.memoBox);
    final Box<BlockitRichTextModel> textBox =
        Hive.box<BlockitRichTextModel>(HiveBoxes.textBox);
    final List<BlockitRichTextModel> lastestText =
        widget.memosModel!.getLatestMemo();
    bool isEdited = false;
    bool isTitleEdited = false;
    // List<String> newMemo = [];

    HiveList<BlockitRichTextModel> newMemo =
        HiveList<BlockitRichTextModel>(textBox);

    for (int index = 0; index < state.length; index++) {
      if (lastestText.length > index) {
        if (lastestText[index].text != state.textAt(index) ||
            lastestText[index].type != state.typeAt(index)) {
          isEdited = true;
          await textBox.put(
              BlockitRichTextModel.getKey(now, index),
              BlockitRichTextModel(
                  text: state.textAt(index),
                  type: state.typeAt(index),
                  textKey: BlockitRichTextModel.getKey(now, index)));
          newMemo.add(textBox.get(BlockitRichTextModel.getKey(now, index))!);
        } else {
          newMemo.add(lastestText[index]);
        }
      } else {
        isEdited = true;
        await textBox.put(
            BlockitRichTextModel.getKey(now, index),
            BlockitRichTextModel(
                text: state.textAt(index),
                type: state.typeAt(index),
                textKey: BlockitRichTextModel.getKey(now, index)));
        newMemo.add(textBox.get(BlockitRichTextModel.getKey(now, index))!);
      }
    }

    if (widget.titleController.text != widget.memosModel!.title) {
      isTitleEdited = true;
      widget.memosModel!.title = widget.titleController.text;
    }

    if (isEdited) {
      widget.memosModel!.memoHistory[now] = newMemo;
      await memoBox.put(widget.memosModel!.memoKey, widget.memosModel!);
    } else if (isTitleEdited) {
      await memoBox.put(widget.memosModel!.memoKey, widget.memosModel!);
    }
  }

  Future _saveNewMemo(EditorProvider state, DateTime now) async {
    final Box<MemosModel> memoBox = Hive.box<MemosModel>(HiveBoxes.memoBox);
    final Box<BlockitRichTextModel> textBox =
        Hive.box<BlockitRichTextModel>(HiveBoxes.textBox);
    HiveList<BlockitRichTextModel> newMemo =
        HiveList<BlockitRichTextModel>(textBox);

    for (int index = 0; index < state.length; index++) {
      await textBox.put(
          BlockitRichTextModel.getKey(now, index),
          BlockitRichTextModel(
              text: state.textAt(index),
              type: state.typeAt(index),
              textKey: BlockitRichTextModel.getKey(now, index)));
      newMemo.add(textBox.get(BlockitRichTextModel.getKey(now, index))!);
    }

    await memoBox.put(
        now.toString(),
        MemosModel(
            colorValue: widget.colorVal,
            memoHistory: {now: newMemo},
            memoWidgetType: 0,
            memoKey: now.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorProvider>(builder: (context, state, _) {
      return IconButton(
          onPressed: () async {
            if (state.length > 0) {
              DateTime now = DateTime.now();

              if (widget.isEdit) {
                await _editOrSave(state, now);
              } else {
                await _saveNewMemo(state, now);
              }

              if (!mounted) return;

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          icon: Icon(
            Icons.save,
            color: AppThemeData.mainGrayColor,
          ));
    });
  }
}
