import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class AppThemeData {
  static Color primaryColor = Colors.red;
  static Color mainGrayColor = const Color.fromARGB(135, 0, 0, 0);
  static Color mainBackgroundWhite = const Color.fromARGB(255, 254, 251, 239);

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
    titleTextStyle: textTheme.headlineSmall,
    actionsIconTheme: IconThemeData(color: mainGrayColor, size: 25),
  );

  static const List<String> _fontFamilyFallback = [
    "Noto_Color_Emoji",
    "Apple Color Emoji",
    "Noto Emoji",
    "Segoe UI Symbol"
  ];

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: 64,
        letterSpacing: 0.0,
        color: mainGrayColor),
    displayMedium: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: 52,
        letterSpacing: 0.0,
        color: mainGrayColor),
    displaySmall: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w700,
        fontSize: 44,
        letterSpacing: 0.0,
        color: mainGrayColor),
    headlineLarge: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 40,
        letterSpacing: 0.0,
        color: mainGrayColor),
    headlineMedium: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 36,
        letterSpacing: 0.0,
        color: mainGrayColor),
    headlineSmall: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 32,
        letterSpacing: 0.0,
        color: mainGrayColor),
    titleLarge: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 22,
        letterSpacing: 0.0,
        color: mainGrayColor),
    titleMedium: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 16,
        letterSpacing: 0.15,
        color: mainGrayColor),
    titleSmall: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 14,
        letterSpacing: 0.1,
        color: mainGrayColor),
    bodyLarge: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 24,
        letterSpacing: 0.15,
        color: mainGrayColor),
    bodyMedium: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w800,
        fontSize: 20,
        letterSpacing: 0.25,
        color: mainGrayColor),
    bodySmall: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: 16,
        letterSpacing: 0.4,
        height: 1.5,
        color: mainGrayColor),
    labelLarge: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        letterSpacing: 0.1,
        color: mainGrayColor),
    labelMedium: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: 12,
        letterSpacing: 0.5,
        color: mainGrayColor),
    labelSmall: TextStyle(
        fontFamily: "Nanum_Myeongjo",
        fontFamilyFallback: _fontFamilyFallback,
        fontWeight: FontWeight.w300,
        fontSize: 9,
        letterSpacing: 0.5,
        color: mainGrayColor),
  );

  static MarkdownStyleSheet markdownStyleSheet = MarkdownStyleSheet(
      p: textTheme.bodySmall,
      pPadding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      code: TextStyle(
          backgroundColor: Colors.transparent,
          color: CupertinoColors.systemGrey6.color,
          fontSize: textTheme.bodySmall!.fontSize! * 0.85),
      h1: textTheme.headlineLarge,
      h1Padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
      h2: textTheme.headlineMedium,
      h2Padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
      h3: textTheme.headlineSmall,
      h3Padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
      h4: textTheme.bodyLarge,
      h4Padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
      h5: textTheme.bodyMedium,
      h5Padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
      h6: textTheme.bodySmall,
      strong: const TextStyle(fontWeight: FontWeight.w800),
      blockquote: const TextStyle(fontWeight: FontWeight.w300),
      blockquoteDecoration: BoxDecoration(
          color: const Color.fromARGB(106, 245, 255, 173),
          borderRadius: BorderRadius.circular(8.0)),
      codeblockDecoration: BoxDecoration(
          color: const Color.fromARGB(106, 0, 0, 0),
          borderRadius: BorderRadius.circular(8.0)));

  static BorderRadius defaultBoxBorderRadius = BorderRadius.circular(12);
  static List<BoxShadow> defaultBoxShadow = [
    const BoxShadow(
        color: Color.fromARGB(32, 148, 148, 148),
        blurRadius: 10,
        spreadRadius: 2)
  ];

  static ButtonStyle defaultElevatedButtonStyle = ElevatedButton.styleFrom(
      primary: primaryColor,
      side: BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(borderRadius: defaultBoxBorderRadius),
      padding: const EdgeInsets.all(12));

  static ButtonStyle transparentElevatedButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onSurface: Colors.transparent,
      onPrimary: Colors.transparent,
      shadowColor: Colors.transparent,
      side: const BorderSide(color: Colors.transparent),
      padding: const EdgeInsets.all(0.0));
}
