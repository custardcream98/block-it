import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Blockit/core/themes/colorPalette.dart';
import 'package:Blockit/core/themes/themeData.dart';

class ColorSelector {
  static Future colorSelectDialog({
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(6.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: AppThemeData.defaultBoxBorderRadius),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4 / 5 * 2,
                child: GridView.builder(
                    itemCount: ColorPalette.colors.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: AppThemeData.transparentElevatedButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pop(index.toString());
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // List<String>? colors = prefs.getStringList('colors');
                          // colors![memoIndex] = index.toString();
                          // prefs.setStringList('colors', colors);
                          // await reloadMemo();
                        },
                        child: Container(
                          // width: 10,
                          // height: 10,
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
