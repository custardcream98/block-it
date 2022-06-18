import 'package:Blockit/core/themes/colorPalette.dart';
import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/screens/home/components/selectColor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemosList extends StatefulWidget {
  MemosList({Key? key}) : super(key: key);

  @override
  State<MemosList> createState() => _MemosListState();
}

class _MemosListState extends State<MemosList> {
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

  Future reloadMemoIfMounted() async {
    reloadMemo();
    if (!mounted) return;
    Navigator.of(context).pop();
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
                            borderRadius: AppThemeData.defaultBoxBorderRadius,
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
                    child: Memo(
                      index: index,
                      memo: memo[index],
                      color: colors[index],
                      reloadMemo: reloadMemo,
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

class Memo extends StatelessWidget {
  Memo(
      {Key? key,
      required this.index,
      required this.memo,
      required this.color,
      required this.reloadMemo})
      : super(key: key);

  int index;
  String memo;
  Color color;
  Future Function() reloadMemo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppThemeData.defaultBoxBorderRadius,
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
                String? newColor = await ColorSelector.colorSelectDialog(
                  context: context,
                );
                if (newColor != null) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String>? colors = prefs.getStringList('colors');
                  colors![index] = newColor;
                  prefs.setStringList('colors', colors);
                  await reloadMemo();
                }
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
