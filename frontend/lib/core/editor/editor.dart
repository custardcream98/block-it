import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'text_widget.dart';
import 'provider.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: Consumer<EditorProvider>(builder: (context, state, _) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.length,
            itemBuilder: (context, index) {
              return Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) state.setFocus(index);
                  },
                  child: BlockitRichTextField(
                    type: state.typeAt(index),
                    controller: state.textControllerAt(index),
                    focusNode: state.focusNodeAt(index),
                  ));
            });
      }),
    );
  }
}
