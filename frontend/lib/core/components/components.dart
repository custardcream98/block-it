import 'package:flutter/material.dart';

class Components {
  static AppBar appBar(
      {Widget? title, List<Widget> actions = const [], Widget? leading}) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: title,
      leading: leading,
      actions: actions,
    );
  }
}
