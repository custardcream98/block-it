import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static Color primaryColor = Colors.red;
  static Color mainGrayColor = const Color.fromARGB(135, 0, 0, 0);

  static ThemeData mainThemeData = ThemeData(
      //fontFamily: 'Noto_Sans_KR',
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      primaryColor: primaryColor,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: defaultElevatedButtonStyle));

  static AppBarTheme appBarTheme = AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 60,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700, color: mainGrayColor, fontSize: 30),
      actionsIconTheme: IconThemeData(color: mainGrayColor, size: 30));

  /// 추후 얼마든지 추가 및 변경이 가능하나, 일단은 기본 머티리얼을 따름
  static TextTheme textTheme = TextTheme(
    titleLarge:
        // TextStyle(
        //     fontFamily: "Dongle",
        //     fontWeight: FontWeight.w700,
        //     fontSize: 37,
        //     letterSpacing: 1.1,
        //     color: mainGrayColor),

        GoogleFonts.dongle(
      textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 37,
          //letterSpacing: 1.1,
          color: mainGrayColor),
    ),

    // TextStyle(
    //   fontFamily: ,
    //     fontWeight: FontWeight.w700, fontSize: 40, letterSpacing: 1.1),
    titleMedium: const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 35, letterSpacing: 1.1),
  );

  static BorderRadius defaultBoxBorder = BorderRadius.circular(12);

  static ButtonStyle defaultElevatedButtonStyle = ElevatedButton.styleFrom(
      primary: primaryColor,
      side: BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(borderRadius: defaultBoxBorder),
      padding: const EdgeInsets.all(12));
}
