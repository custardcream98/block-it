import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/memo.dart';
import '/core/constants/constants.dart';

class MemoBox extends StatelessWidget {
  const MemoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MemoList extends StatefulWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  State<MemoList> createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  bool _isReloaded = false;
  Box memoBox = Hive.box(HiveBoxes.memoBox);

  @override
  void initState() {
    super.initState();
  }

  // void _reloadMemo() {

  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //itemCount: ,
        itemBuilder: (context, index) {
      return SizedBox();
    });
  }
}
