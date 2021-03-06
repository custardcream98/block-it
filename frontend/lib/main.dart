import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
//import 'package:provider/provider.dart';

import 'core/models/memo.dart';
import 'core/models/rich_text.dart';
import 'core/themes/theme_data.dart';
import 'core/constants/constants.dart';
import 'screens/home/home_screen.dart';

void main() async {
  // init HIVE
  await Hive.initFlutter();
  Hive.registerAdapter<MemosModel>(MemosModelAdapter());
  Hive.registerAdapter<BlockitRichTextModel>(BlockitRichTextModelAdapter());
  Hive.registerAdapter<BlockitRichTextType>(BlockitRichTextTypeAdapter());

  // open HIVE BOX
  await Hive.openBox<MemosModel>(HiveBoxes.memoBox);
  await Hive.openBox<BlockitRichTextModel>(HiveBoxes.textBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '블록잇',
      theme: AppThemeData.mainThemeData,
      home: const HomeScreen(),
    );
  }
}
