import 'package:flutter/material.dart';

class AppThemeData {
  static Color primaryColor = Colors.red;
  static Color mainGrayColor = const Color.fromARGB(135, 0, 0, 0);
  static Color mainBackgroundWhite = Color.fromARGB(255, 254, 251, 239);

  static ThemeData mainThemeData = ThemeData(
      fontFamily: 'Noto_Sans_KR',
      backgroundColor: mainBackgroundWhite,
      primaryColor: primaryColor,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: defaultElevatedButtonStyle));

  static AppBarTheme appBarTheme = AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 60,
      titleTextStyle: textTheme.titleLarge,
      actionsIconTheme: IconThemeData(color: mainGrayColor, size: 25));

  static TextTheme textTheme = TextTheme(
      titleLarge: TextStyle(
          fontFamily: "Nanum_Myeongjo",
          fontWeight: FontWeight.w800,
          fontSize: 35,
          letterSpacing: 0.5,
          color: mainGrayColor),
      titleMedium: TextStyle(
          fontFamily: "Nanum_Myeongjo",
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 1.1,
          color: mainGrayColor),
      bodyMedium: TextStyle(
          fontFamily: "Nanum_Myeongjo",
          fontWeight: FontWeight.w700,
          fontSize: 15,
          letterSpacing: 1.1,
          color: mainGrayColor)

      // const TextStyle(
      //     fontWeight: FontWeight.w700, fontSize: 35, letterSpacing: 1.1),
      );

  static BorderRadius defaultBoxBorder = BorderRadius.circular(12);
  static List<BoxShadow> defaultBoxShadow = [
    const BoxShadow(
        color: Color.fromARGB(32, 148, 148, 148),
        blurRadius: 10,
        spreadRadius: 2)
  ];

  static ButtonStyle defaultElevatedButtonStyle = ElevatedButton.styleFrom(
      primary: primaryColor,
      side: BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(borderRadius: defaultBoxBorder),
      padding: const EdgeInsets.all(12));
}
