import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:Blockit/core/constants/constants.dart';
import 'package:Blockit/core/constants/infoStrings.dart';
import 'package:Blockit/core/themes/themeData.dart';
import 'package:Blockit/core/components/components.dart';
import 'package:Blockit/screens/home/components/memoWidgets.dart';
import 'package:Blockit/screens/edit_memo/editMemoScreen.dart';
import 'package:Blockit/screens/edit_memo/components/editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (MediaQuery.of(context).size.width > 1000) {
      return Scaffold(
          backgroundColor: AppThemeData.mainBackgroundWhite,
          body: Center(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2 - 80,
              ),
              const Text(
                '📱',
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(
                height: 30,
              ),
              Text("모바일 환경에서 만나보세요!", style: AppThemeData.textTheme.titleLarge),
            ],
          )));
    }
    return Scaffold(
      backgroundColor: AppThemeData.mainBackgroundWhite,
      appBar: Components.appBar(
          actions: AppBarActions.actions(context: context),
          title: ElevatedButton(
              style: AppThemeData.transparentElevatedButtonStyle,
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          scrollable: true,
                          backgroundColor: AppThemeData.mainBackgroundWhite,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  AppThemeData.defaultBoxBorderRadius),
                          content: MarkdownBody(
                            styleSheet: AppThemeData.markdownStyleSheet,
                            listItemCrossAxisAlignment:
                                MarkdownListItemCrossAxisAlignment.start,
                            extensionSet: md.ExtensionSet(
                                md.ExtensionSet.gitHubWeb.blockSyntaxes,
                                ModeifiedMarkDownSyntaxes.inlineSyntaxes),
                            onTapLink: (text, url, title) {
                              launchUrl(Uri.parse(url!));
                            },
                            data: InfoString.introduce,
                          ));
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: AppThemeData.defaultBoxShadow,
                    ),
                    padding: EdgeInsets.only(right: 4),
                    child: const Image(
                        width: 25,
                        height: 25,
                        fit: BoxFit.contain,
                        image: AssetImage(Assets.boxIconDir)),
                  ),
                  Text(
                    "block it",
                    style: AppThemeData.textTheme.headlineSmall,
                  ),
                ],
              ))),
      body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Expanded(child: MemosList()),
            ],
          )),
    );
  }
}

class AppBarActions {
  static List<Widget> actions({required BuildContext context}) {
    return [
      IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreatePlanScreen(),
              )),
          icon:
              const Icon(CupertinoIcons.plus_rectangle_fill_on_rectangle_fill))
    ];
  }
}
