import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:Blockit/core/constants/constants.dart';
import 'package:Blockit/core/models/memo.dart';
import 'package:Blockit/core/themes/theme_data.dart';
import 'package:Blockit/core/components/select_color.dart';

import 'package:Blockit/screens/edit_memo/edit_memo_screen.dart';
import 'package:Blockit/screens/edit_memo/components/editor.dart';

class MemosList extends StatefulWidget {
  const MemosList({Key? key}) : super(key: key);

  @override
  State<MemosList> createState() => _MemosListState();
}

class _MemosListState extends State<MemosList> {
  bool _isReloaded = false;
  List<MemosModel> memos = [];

  Future reloadMemo() async {
    setState(() {
      _isReloaded = false;
    });

    final Box<MemosModel> memoBox = Hive.box<MemosModel>(HiveBoxes.memoBox);

    List<MemosModel> memos = memoBox.values.toList();

    setState(() {
      this.memos = memos;
      _isReloaded = true;
    });
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
      if (memos.isEmpty) {
        return SizedBox(
          height: 100,
          width: double.infinity,
          child: Center(
              child: Text(
            '메모가 없습니다',
            style: Theme.of(context).textTheme.labelLarge,
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
              for (MemosModel memo in memos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(memo.generatedTimestamp.toString()),
                    //crossAxisEndOffset: 200,
                    secondaryBackground: Container(
                      padding: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: AppThemeData.defaultBoxBorderRadius,
                          color: Colors.red),
                      child: Icon(
                        Icons.delete_rounded,
                        size: 20,
                        color: AppThemeData.mainGrayColor,
                      ),
                    ),
                    background: Container(
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: AppThemeData.defaultBoxBorderRadius,
                          color: Colors.green),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: AppThemeData.mainGrayColor,
                      ),
                    ),
                    onDismissed: (direction) async {
                      final Box<MemosModel> memoBox =
                          Hive.box<MemosModel>(HiveBoxes.memoBox);
                      MemosModel memosModel;
                      if (direction == DismissDirection.startToEnd) {
                        memosModel =
                            memoBox.get(memo.generatedTimestamp.toString())!;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePlanScreen(
                                  isEdit: true, memo: memosModel),
                            ));
                        return;
                      }
                      memoBox.delete(memo.generatedTimestamp.toString());

                      await reloadMemo();
                    },
                    child: MemoWidget(
                      memo: memo,
                      reloadMemo: reloadMemo,
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Text(
                    '메모를 지우려면 ⬅️ 수정하려면 ➡️',
                    style: Theme.of(context).textTheme.labelMedium,
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

class MemoWidget extends StatelessWidget {
  const MemoWidget({Key? key, required this.memo, required this.reloadMemo})
      : super(key: key);

  final MemosModel memo;
  final Future Function() reloadMemo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding:
                EdgeInsets.fromLTRB(12, (memo.title.isEmpty ? 12 : 22), 30, 12),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppThemeData.defaultBoxBorderRadius,
                boxShadow: AppThemeData.defaultBoxShadow),
            child: Align(
              alignment: Alignment.centerLeft,
              child: MarkdownBody(
                styleSheet: AppThemeData.markdownStyleSheet,
                extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubWeb.blockSyntaxes,
                    ModeifiedMarkDownSyntaxes.inlineSyntaxes),
                data: memo.memo,
              ),
            )),
        Positioned.fill(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 28, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      memo.title,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      memo.getgeneratedTimeString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox.shrink())
              ],
            ),
          ),
        ),
        Positioned.fill(
            child: Row(
          children: [
            const Expanded(child: SizedBox.shrink()),
            GestureDetector(
              onTap: () async {
                int? newColorVal = await ColorSelector.colorSelectDialog(
                  context: context,
                );
                if (newColorVal != null) {
                  final Box<MemosModel> memoBox =
                      Hive.box<MemosModel>(HiveBoxes.memoBox);
                  memo.colorValue = newColorVal;
                  memoBox.put(memo.generatedTimestamp.toString(), memo);

                  await reloadMemo();
                }
              },
              child: Container(
                width: 23,
                decoration: BoxDecoration(
                    color: Color(memo.colorValue),
                    borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(12),
                        bottomEnd: Radius.circular(12))),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
