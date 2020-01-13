import 'package:flutter/widgets.dart';

class NavigationBarItem {
  const NavigationBarItem(
      {@required this.bottomNavigationBarItem, @required this.navigatorKey})
      : assert(bottomNavigationBarItem != null),
        assert(navigatorKey != null);

  final BottomNavigationBarItem bottomNavigationBarItem;
  final GlobalKey<NavigatorState> navigatorKey;
}
