import 'package:flutter/material.dart';

class Components {
  static AppBar appBar(
      {required BuildContext context,
      String title = "",
      List<Widget> actions = const []}) {
    return AppBar(
      elevation: 0.0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      // bottom: PreferredSize(
      //   child: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Padding(
      //       padding: const EdgeInsets.only(bottom: 5, left: 10),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Text(
      //             "Less,",
      //             style: Theme.of(context).textTheme.titleMedium,
      //             textAlign: TextAlign.start,
      //           ),
      //           Text(
      //             "but Better.",
      //             style: Theme.of(context).textTheme.titleLarge,
      //             textAlign: TextAlign.start,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   preferredSize: Size(double.infinity, 100.0),
      // ),

      // SizedBox(
      //   height: 100,
      //   width: double.infinity,
      //   child: Center(
      //     child:
      //     ),
      //   ),
      // ),
      actions: actions,
    );
  }

  // AppBar(
  //   // NO TITLE! LeTTER
  //   // title: const Text(
  //   //   "MapIt",
  //   // ),
  //   // centerTitle: false,
  //   elevation: 1.0,
  // );
}

class BlockitAppBar extends AppBar {
  BlockitAppBar({Key? key}) : super(key: key);
}
