import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/memo.dart';
import '../models/rich_text.dart';

class EditorProvider with ChangeNotifier {
  EditorProvider({
    bool isEdit = false,
    MemosModel? memosModel,
  }) {
    if (!isEdit) {
      insert(index: 0);
    } else {
      loadMemo(memosModel!);
    }
  }

  // ignore: prefer_final_fields
  List<FocusNode> _focusNodes = [];
  // ignore: prefer_final_fields
  List<TextEditingController> _textControllers = [];
  // ignore: prefer_final_fields
  List<BlockitRichTextType> _types = [];
  BlockitRichTextType selectedType = BlockitRichTextType.p;

  int lastFocus = 0;

  void loadMemo(MemosModel memosModel) {
    List<BlockitRichTextModel> latestMemo = memosModel.getLatestMemo();

    for (int index = 0; index < latestMemo.length; index++) {
      insert(
          index: index,
          text: latestMemo[index].text,
          type: latestMemo[index].type);
    }

    setFocus(latestMemo.length - 1);
    focusNodeAt(latestMemo.length - 1).requestFocus();
  }

  int get length => _textControllers.length;
  FocusNode focusNodeAt(int index) => _focusNodes.elementAt(index);
  TextEditingController textControllerAt(int index) =>
      _textControllers.elementAt(index);
  String textAt(int index) =>
      _textControllers.elementAt(index).text.replaceFirst('\u200B', "");
  BlockitRichTextType typeAt(int index) => _types.elementAt(index);

  void setType(BlockitRichTextType type) {
    if (selectedType == type) {
      selectedType = BlockitRichTextType.p; // 해제
    } else {
      selectedType = type;
    }
    _types.removeAt(lastFocus);
    _types.insert(lastFocus, selectedType);
    focusNodeAt(lastFocus).requestFocus();
    notifyListeners();
  }

  void setFocus(int focusIndex) {
    selectedType = typeAt(focusIndex);
    lastFocus = focusIndex;
    notifyListeners();
  }

  void insert(
      {required int index,
      String? text,
      BlockitRichTextType type = BlockitRichTextType.p}) {
    final TextEditingController controller =
        TextEditingController(text: '\u200B${text ?? ''}');

    controller.addListener(() {
      final int index = _textControllers.indexOf(controller);

      if (!controller.text.startsWith('\u200B')) {
        if (index > 0) {
          if (typeAt(index) != BlockitRichTextType.bullet) {
            textControllerAt(index - 1).text += controller.text;
            textControllerAt(index - 1).selection = TextSelection.fromPosition(
                TextPosition(
                    offset: textControllerAt(index - 1).text.length -
                        controller.text.length));
            focusNodeAt(index - 1).requestFocus();
            selectedType = BlockitRichTextType.p;
            _textControllers.removeAt(index);
            _focusNodes.removeAt(index);
            _types.removeAt(index);
          } else {
            setType(BlockitRichTextType.bullet);
            controller.text = '\u200B${controller.text}';
            controller.selection =
                TextSelection.fromPosition(const TextPosition(offset: 1));
          }
          notifyListeners();
        }
      }
      if (controller.text.contains('\n')) {
        List<String> split = controller.text.split('\n');
        controller.text = split.first;
        insert(
            index: index + 1,
            text: split.last,
            type: typeAt(index) == BlockitRichTextType.bullet
                ? BlockitRichTextType.bullet
                : BlockitRichTextType.p);
        textControllerAt(index + 1).selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
        focusNodeAt(index + 1).requestFocus();
        notifyListeners();
      }
    });

    _textControllers.insert(index, controller);
    _types.insert(index, type);

    FocusNode focusNode = FocusNode();

    focusNode.onKeyEvent = ((focusNode, keyEvent) {
      if (keyEvent.runtimeType == KeyDownEvent) {
        if (keyEvent.logicalKey == LogicalKeyboardKey.arrowUp) {
          moveUpDown(index, -1);
          return KeyEventResult.handled;
        } else if (keyEvent.logicalKey == LogicalKeyboardKey.arrowDown) {
          moveUpDown(index, 1);
          return KeyEventResult.handled;
        }
      }
      return KeyEventResult.ignored;
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        lastFocus = index;
      }
    });
    _focusNodes.insert(index, focusNode);

    notifyListeners();
  }

  void moveUpDown(int index, int moveAmount) {
    if ((index > 0 && moveAmount < 0) ||
        (index < length - 1 && moveAmount > 0)) {
      int? offset;
      int textAtOffset = textAt(index + moveAmount).length + 1;
      if (textControllerAt(index).selection.isCollapsed &&
          typeAt(index) == typeAt(index + moveAmount)) {
        offset = textControllerAt(index).selection.baseOffset;
        offset =
            textAt(index + moveAmount).length >= offset ? offset : textAtOffset;
      }

      setFocus(index + moveAmount);

      textControllerAt(lastFocus).selection = TextSelection.fromPosition(
          TextPosition(offset: offset ?? textAtOffset));
    }
    focusNodeAt(lastFocus).requestFocus();
    notifyListeners();
  }

  void moveUp() => moveUpDown(lastFocus, -1);
  void moveDown() => moveUpDown(lastFocus, 1);
}
