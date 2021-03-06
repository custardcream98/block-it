import 'package:flutter/material.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/info_strings.dart';
import '../../core/themes/theme_data.dart';
import '../../core/components/components.dart';
import '../../core/editor/memo_list.dart';
import '../edit_memo/edit_memo_screen.dart';
// import '/screens/edit_memo/components/editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    // if (MediaQuery.of(context).size.width > 1000) {
    //   return Scaffold(
    //       backgroundColor: AppThemeData.mainBackgroundWhite,
    //       body: Center(
    //           child: Column(
    //         children: [
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height / 2 - 80,
    //           ),
    //           const Text(
    //             'π±',
    //             style: TextStyle(fontSize: 50),
    //           ),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           Text("λͺ¨λ°μΌ νκ²½μμ λ§λλ³΄μΈμ!", style: AppThemeData.textTheme.titleLarge),
    //         ],
    //       )));
    // }
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
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MarkdownBody(
                                styleSheet: AppThemeData.markdownStyleSheet,
                                listItemCrossAxisAlignment:
                                    MarkdownListItemCrossAxisAlignment.start,
                                extensionSet: md.ExtensionSet(
                                    md.ExtensionSet.gitHubWeb.blockSyntaxes, [
                                  md.EmojiSyntax(),
                                  ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                                ]),
                                onTapLink: (text, url, title) {
                                  launchUrl(Uri.parse(url!));
                                },
                                data: InfoString.introduce,
                              ),
                              ...InfoString.copyright
                            ],
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
                    padding: const EdgeInsets.only(right: 4),
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
      body: const Padding(
          padding: EdgeInsets.only(left: 12, right: 12), child: MemoList()),
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
                builder: (context) => const EditMemoScreen(),
              )),
          icon: const Icon(Icons.add_rounded))
    ];
  }
}
