import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/screens/home/homeScreen.dart';
import 'package:flutter/material.dart';

import 'package:Blockit/core/themes/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  TextEditingController memoTitleController = TextEditingController();

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
            IconButton(
                onPressed: () async {
                  if (memoTitleController.text.isNotEmpty) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.getStringList('articles') == null) {
                      prefs.setStringList(
                          'articles', [memoTitleController.text]);
                    } else {
                      List<String>? articles = prefs.getStringList('articles');
                      articles!.add(memoTitleController.text);
                      prefs.setStringList('articles', articles);
                    }

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
            padding: EdgeInsets.only(left: 15, right: 15),
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

// class GetNewMemo extends StatefulWidget {
//   const GetNewMemo({Key? key}) : super(key: key);

//   @override
//   State<GetNewMemo> createState() => _GetNewMemoState();
// }

// class _GetNewMemoState extends State<GetNewMemo> {
//   //ScrollController _scrollController = ScrollController();

//   TextEditingController memoTitleController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       //controller: _scrollController,
//       child: Column(
//         children: [],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     memoTitleController.dispose();
//     super.dispose();
//   }
// }
