import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../../screens/edit_memo/edit_memo_screen.dart';
import 'memo_box.dart';
import '../models/memo.dart';
import '../themes/theme_data.dart';
import '../constants/constants.dart';

class MemoList extends StatefulWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  State<MemoList> createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  bool _isReloaded = false;

  List<MemosModel> _memoModels = [];

  Future reloadMemo() async {
    setState(() {
      _isReloaded = false;
    });

    final Box<MemosModel> memoBox = Hive.box<MemosModel>(HiveBoxes.memoBox);
    List<MemosModel> memos = memoBox.values.toList();

    setState(() {
      _memoModels = memos;
      print(_memoModels);
      _isReloaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    reloadMemo();
  }

  Widget _dismissContainer({required bool isDelete}) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: isDelete ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppThemeData.defaultBoxBorderRadius,
            color: isDelete ? Colors.red : Colors.green),
        child: Icon(
          isDelete ? Icons.delete_rounded : Icons.edit,
          size: 20,
          color: AppThemeData.mainGrayColor,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (_isReloaded) {
      if (_memoModels.isEmpty) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (MemosModel memoModel in _memoModels)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Dismissible(
                    key: Key(memoModel.firstEdited.toString()),
                    background: _dismissContainer(isDelete: false),
                    secondaryBackground: _dismissContainer(isDelete: true),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMemoScreen(
                                  isEdit: true, memoModelForEdit: memoModel),
                            ));
                        return;
                      } else {
                        final Box<MemosModel> memoBox =
                            Hive.box<MemosModel>(HiveBoxes.memoBox);

                        await memoBox.delete(memoModel.memoKey);
                        await reloadMemo();
                      }
                    },
                    child: MemoBox(
                      memoModel: memoModel,
                      reloadMemo: reloadMemo,
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
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
