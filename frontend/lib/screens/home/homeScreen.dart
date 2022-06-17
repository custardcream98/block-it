import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/screens/create_plan/createPlanScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.mainBackgroundWhite,
      appBar: Components.appBar(
          actions: AppBarActions.actions(context: context),
          title: const Text("block it")),
      body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12), child: Memos()),
    );
  }
}

class Memos extends StatefulWidget {
  Memos({Key? key}) : super(key: key);

  @override
  State<Memos> createState() => _MemosState();
}

class _MemosState extends State<Memos> {
  bool _isReloaded = false;
  List<String> memo = [];

  Future reloadMemo() async {
    setState(() {
      _isReloaded = false;
      memo = [];
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articles = prefs.getStringList('articles');
    if (articles == null) {
      setState(() {
        _isReloaded = true;
      });
    } else {
      setState(() {
        memo = articles;
        _isReloaded = true;
      });
    }
  }

  @override
  void initState() {
    reloadMemo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isReloaded) {
      if (memo.isEmpty) {
        return SizedBox(
          height: 100,
          width: double.infinity,
          child: Center(
              child: Text(
            '메모가 없습니다',
            style: Theme.of(context).textTheme.bodyMedium,
          )),
        );
      }
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 65,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              for (int index = 0; index < memo.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(memo[index]),
                    // confirmDismiss: (direction) async {
                    //   if (direction == DismissDirection.horizontal) {
                    //     return await showCupertinoDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return CupertinoAlertDialog(
                    //             title: const Text('메모를 지울까요?'),
                    //             actions: [
                    //               CupertinoDialogAction(
                    //                 child: const Text('✅'),
                    //                 onPressed: () => Navigator.pop(context, true),
                    //               ),
                    //               CupertinoDialogAction(
                    //                 child: const Text('❌'),
                    //                 onPressed: () => Navigator.pop(context, false),
                    //               )
                    //             ],
                    //           );
                    //         });
                    //   } else {
                    //     return false;
                    //   }
                    // },
                    background: Container(
                        decoration: BoxDecoration(
                            borderRadius: AppThemeData.defaultBoxBorder,
                            color: Colors.red)),
                    onDismissed: (direction) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      List<String>? articles = prefs.getStringList('articles');
                      articles!.removeAt(index);
                      prefs.setStringList('articles', articles);
                      await reloadMemo();
                    },
                    child: Articles(index: index, memo: memo[index]),
                  ),
                ),
              // Flexible(
              //   fit: FlexFit.loose,
              //   child: ListView.builder(
              //       controller: _scrollController,
              //       itemCount: memo.length,
              //       itemBuilder: (context, index) {
              //         return Dismissible(
              //           key: Key(memo[index]),
              //           confirmDismiss: (direction) async {
              //             if (direction == DismissDirection.endToStart) {
              //               return await showCupertinoDialog(
              //                   context: context,
              //                   builder: (context) {
              //                     return CupertinoAlertDialog(
              //                       title: const Text('메모를 지울까요?'),
              //                       actions: [
              //                         CupertinoDialogAction(
              //                           child: const Text('✅'),
              //                           onPressed: () =>
              //                               Navigator.pop(context, true),
              //                         ),
              //                         CupertinoDialogAction(
              //                           child: const Text('❌'),
              //                           onPressed: () =>
              //                               Navigator.pop(context, false),
              //                         )
              //                       ],
              //                     );
              //                   });
              //             } else {
              //               return false;
              //             }
              //           },
              //           background: Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: AppThemeData.defaultBoxBorder,
              //                   color: Colors.red)),
              //           onDismissed: (direction) async {
              //             SharedPreferences prefs =
              //                 await SharedPreferences.getInstance();
              //             List<String>? articles =
              //                 prefs.getStringList('articles');
              //             articles!.removeAt(index);
              //             prefs.setStringList('articles', articles);
              //             await reloadMemo();
              //           },
              //           child: Articles(
              //               index: index, memo: memo[index], reload: reloadMemo),
              //         );
              //       }),
              // ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Text(
                    '메모를 지우려면 스와이프',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: AppThemeData.mainGrayColor,
          ),
        ),
      );
    }
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

class Articles extends StatelessWidget {
  Articles({Key? key, required this.index, required this.memo})
      : super(key: key);

  int index;
  String memo;
  //Future Function() reload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppThemeData.defaultBoxBorder,
          boxShadow: AppThemeData.defaultBoxShadow),
      child: Text(memo),

      // Row(
      //   children: [
      //     Expanded(child: Text(memo)),
      //     IconButton(
      //         onPressed: () async {
      //           SharedPreferences prefs = await SharedPreferences.getInstance();
      //           List<String>? articles = prefs.getStringList('articles');
      //           articles!.removeAt(index);
      //           prefs.setStringList('articles', articles);
      //           await reload();
      //         },
      //         icon: Icon(
      //           CupertinoIcons.clear,
      //           color: AppThemeData.mainGrayColor,
      //           size: 15,
      //         ))
      //   ],
      // ),
    );
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