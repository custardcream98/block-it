import 'package:flutter/material.dart';

import 'package:Blockit/core/themes/colorPalette.dart';
import 'package:Blockit/core/themes/themeData.dart';

class ColorSelector {
  static Future colorSelectDialog({
    required BuildContext context,
  }) async {
    double boxWidth = 35;
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(6.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: AppThemeData.defaultBoxBorderRadius),
              content: SizedBox(
                width: boxWidth * 5 + 12,
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: ColorPalette.colors.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: AppThemeData.transparentElevatedButtonStyle,
                        onPressed: () {
                          Navigator.of(context)
                              .pop(ColorPalette.colors[index].value);
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // List<String>? colors = prefs.getStringList('colors');
                          // colors![memoIndex] = index.toString();
                          // prefs.setStringList('colors', colors);
                          // await reloadMemo();
                        },
                        child: Container(
                          width: boxWidth,
                          height: boxWidth,
                          decoration: BoxDecoration(
                              color: ColorPalette.colors[index],
                              borderRadius:
                                  AppThemeData.defaultBoxBorderRadius),
                        ),
                      );
                    }),
              ));
        });
  }
}
