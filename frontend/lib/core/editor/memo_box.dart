import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../components/select_color.dart';
import '../constants/constants.dart';
import '../models/memo.dart';
import '../models/rich_text.dart';
import '../themes/theme_data.dart';
import 'text_widget.dart';

class MemoBox extends StatelessWidget {
  const MemoBox({Key? key, required this.memoModel, required this.reloadMemo})
      : super(key: key);

  final MemosModel memoModel;
  final Future Function() reloadMemo;

  @override
  Widget build(BuildContext context) {
    List<BlockitRichTextModel> memoTextModelList = memoModel.getLatestMemo();

    return Stack(
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(
                12, memoModel.title.isNotEmpty ? 22 : 12, 30, 12),
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppThemeData.defaultBoxBorderRadius,
                boxShadow: AppThemeData.defaultBoxShadow),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: memoTextModelList.length,
                itemBuilder: (context, index) =>
                    BlockitRichText(richText: memoTextModelList[index]))),
        Positioned.fill(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 28, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      memoModel.title,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      memoModel.editedAtString(),
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
                  memoModel.colorValue = newColorVal;
                  final Box<MemosModel> memoBox =
                      Hive.box<MemosModel>(HiveBoxes.memoBox);
                  await memoBox.put(memoModel.memoKey, memoModel);

                  await reloadMemo();
                }
              },
              child: Container(
                width: 23,
                decoration: BoxDecoration(
                    color: Color(memoModel.colorValue),
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
