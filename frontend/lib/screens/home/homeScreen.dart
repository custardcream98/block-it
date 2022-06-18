import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/screens/home/components/memos.dart';
import 'package:Blockit/screens/create_plan/createPlanScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   FocusScope.of(context).unfocus();
  // }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      backgroundColor: AppThemeData.mainBackgroundWhite,
      appBar: Components.appBar(
          actions: AppBarActions.actions(context: context),
          title: const Text("block it")),
      body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: MemosList()),
    );
  }
}

class AppBarActions {
  static List<Widget> actions({required BuildContext context}) {
    return [
      IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePlanScreen(),
              )),
          icon:
              const Icon(CupertinoIcons.plus_rectangle_fill_on_rectangle_fill))
    ];
  }
}


// class AlertBox extends StatelessWidget {
//   const AlertBox({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: AppThemeData.defaultBoxBorder,
//           boxShadow: AppThemeData.defaultBoxShadow),
//     );
//   }
// }
