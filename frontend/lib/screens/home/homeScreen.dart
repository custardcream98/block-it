import 'package:Blockit/core/themes/colorPalette.dart';
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
  List<Color> colors = [];

  Future reloadMemo() async {
    setState(() {
      _isReloaded = false;
      memo = [];
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articles = prefs.getStringList('articles');
    List<String>? colorsGot = prefs.getStringList('colors');

    if (articles == null) {
      setState(() {
        _isReloaded = true;
      });
    } else {
      setState(() {
        memo = articles;
        colors =
            colorsGot!.map((e) => ColorPalette.colors[int.parse(e)]).toList();
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
                      List<String>? colors = prefs.getStringList('colors');
                      colors!.removeAt(index);
                      prefs.setStringList('colors', colors);

                      await reloadMemo();
                    },
                    child: Articles(
                      index: index,
                      memo: memo[index],
                      color: colors[index],
                    ),
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
  Articles(
      {Key? key, required this.index, required this.memo, required this.color})
      : super(key: key);

  int index;
  String memo;
  Color color;
  //Future Function() reload;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppThemeData.defaultBoxBorder,
                boxShadow: AppThemeData.defaultBoxShadow),
            child: Row(
              children: [
                Expanded(child: Text(memo)),
                const SizedBox(
                  width: 32,
                )
              ],
            )),
        Positioned.fill(
            child: Row(
          children: [
            const Expanded(child: SizedBox.shrink()),
            GestureDetector(
              onTap: () async {
                // await showCupertinoDialog(
                //     context: context,
                //     builder: (context) {
                //       return CupertinoAlertDialog(
                //           title: Text('ff'),
                //           content: GridView.builder(
                //               itemCount: ColorPalette.colors.length,
                //               gridDelegate:
                //                   const SliverGridDelegateWithFixedCrossAxisCount(
                //                       crossAxisCount: 5,
                //                       childAspectRatio: 1,
                //                       mainAxisSpacing: 2,
                //                       crossAxisSpacing: 2),
                //               itemBuilder: (context, index) => Container(
                //                     width: 15,
                //                     height: 15,
                //                     decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(50),
                //                         color: ColorPalette.colors[index]),
                //                   )));
                //     });
              },
              child: Container(
                width: 20,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(12),
                        bottomEnd: Radius.circular(12))),
              ),
            ),
          ],
        ))
      ],
    );

    //   Row(
    //     children: [
    //       Expanded(child: Text(memo)),
    //       Container(
    //         height: 10,
    //         width: 20,
    //         color: Colors.black,
    //       )
    //     ],
    //   ),
    // );
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
