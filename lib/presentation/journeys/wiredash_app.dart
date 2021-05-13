import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class WireDashApp extends StatelessWidget {

  final navigatorKey;
  final Widget child;

  WireDashApp({@required this.navigatorKey, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'bible-casts-nakzrtv',
      secret: '4lrdlle3j8jcpoq9bsvxolfewbnsuxg6yru3x5qwvlw772y3',
      theme: WiredashThemeData(
        brightness: Brightness.light,
        primaryColor: Theme.of(context).primaryColor,
      ),
      navigatorKey: navigatorKey,
      child: child
    );
  }
}
