import 'package:flutter/material.dart';

class ScaffoldDictionary extends StatelessWidget {
  const ScaffoldDictionary({Key? key, this.bottomNavigationBar, this.body})
      : super(key: key);
  final Widget? bottomNavigationBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SafeArea(
            child: Scaffold(
          bottomNavigationBar: bottomNavigationBar,
          body: body,
        )));
  }
}
