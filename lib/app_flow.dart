import 'package:flutter/widgets.dart';

// Holds information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.title,
    @required this.mainColor,
    @required this.iconData,
    @required this.navigatorKey,
  })  : assert(title != null),
        assert(mainColor != null),
        assert(iconData != null);

  final String title;
  final Color mainColor;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigatorKey;
}
