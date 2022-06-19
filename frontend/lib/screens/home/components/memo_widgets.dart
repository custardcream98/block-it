import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:Blockit/core/constants/constants.dart';
import 'package:Blockit/core/models/memo.dart';
import 'package:Blockit/core/themes/theme_data.dart';
import 'package:Blockit/core/components/select_color.dart';
import 'package:Blockit/screens/edit_memo/components/editor.dart';

class MemosList extends StatefulWidget {
  MemosList({Key? key}) : super(key: key);

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

    final Box<MemosModel> _memoBox =
        await Hive.box<MemosModel>(HiveBoxes.memoBox);

    List<MemosModel> _memos = _memoBox.values.toList();

    setState(() {
      memos = _memos;
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
              for (MemosModel _memo in memos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(_memo.generatedTimestamp.toString()),
                    background: Container(
                        decoration: BoxDecoration(
                            borderRadius: AppThemeData.defaultBoxBorderRadius,
                            color: Colors.red)),
                    onDismissed: (direction) async {
                      final Box<MemosModel> _memoBox =
                          Hive.box<MemosModel>(HiveBoxes.memoBox);

                      _memoBox.delete(_memo.generatedTimestamp.toString());

                      await reloadMemo();
                    },
                    child: MemoWidget(
                      memo: _memo,
                      reloadMemo: reloadMemo,
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Text(
                    '메모를 지우려면 스와이프',
                    style: Theme.of(context).textTheme.labelLarge,
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
                EdgeInsets.fromLTRB(12, (memo.title.isEmpty ? 8 : 17), 30, 12),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppThemeData.defaultBoxBorderRadius,
                boxShadow: AppThemeData.defaultBoxShadow),
            child: MarkdownBody(
              styleSheet: AppThemeData.markdownStyleSheet,
              extensionSet: md.ExtensionSet(
                  md.ExtensionSet.gitHubWeb.blockSyntaxes,
                  ModeifiedMarkDownSyntaxes.inlineSyntaxes),
              data: memo.memo,
            )),
        Positioned.fill(
          top: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 28, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  final Box<MemosModel> _memoBox =
                      Hive.box<MemosModel>(HiveBoxes.memoBox);
                  memo.colorValue = newColorVal;
                  _memoBox.put(memo.generatedTimestamp.toString(), memo);

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
