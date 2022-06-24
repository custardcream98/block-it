import 'package:flutter/material.dart';

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
          text: latestMemo[index].text.replaceFirst('\u200B', ""),
          type: latestMemo[index].type);
    }

    setFocus(latestMemo.length - 1);
    focusNodeAt(latestMemo.length - 1).requestFocus();
  }

  int get length => _textControllers.length;
  FocusNode focusNodeAt(int index) => _focusNodes.elementAt(index);
  TextEditingController textControllerAt(int index) =>
      _textControllers.elementAt(index);
  String textAt(int index) => _textControllers.elementAt(index).text;
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
    _focusNodes.insert(index, FocusNode());

    notifyListeners();
  }
}
