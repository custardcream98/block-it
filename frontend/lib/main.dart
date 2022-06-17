import 'package:Blockit/core/classes/classes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/screens/home/homeScreen.dart';

void main() async {
  //sawait Hive.initFlutter(); //not needed in browser!

  runApp(const MyApp()
      //MultiProvider(providers: [], child: const MyApp())
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (true
        // defaultTargetPlatform == TargetPlatform.iOS ||
        //   defaultTargetPlatform == TargetPlatform.android
        ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blockit',
        theme: AppThemeData.mainThemeData,
        home: const HomeScreen(),
      );
    }
    // else {
    //   return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       home: Scaffold(
    //           body: Center(
    //               child: ElevatedButton(
    //         style: MapitThemeData.defaultElevatedButtonStyle,
    //         child: const Text(
    //           "모바일 환경에서 만나보세요!",
    //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    //         ),
    //         onPressed: () {},
    //       ))));
    // }
  }
}
