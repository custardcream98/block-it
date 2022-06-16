import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Blockit/core/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.appBar(
          context: context, actions: AppBarActions.actions, title: "block it"),
      body: Column(children: [Container()]),
    );
  }
}

class AppBarActions {
  static List<Widget> actions = [
    IconButton(onPressed: () {}, icon: Icon(Icons.add_box_rounded))
  ];
}
