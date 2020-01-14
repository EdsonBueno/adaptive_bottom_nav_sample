import 'package:flutter/widgets.dart';

/// Contains the necessary parameters for building either a
/// [MaterialBottomNavigationScaffold] or [CupertinoBottomNavigationScaffold].
class BottomNavigationTab {
  const BottomNavigationTab(
      {@required this.bottomNavigationBarItem, @required this.navigatorKey})
      : assert(bottomNavigationBarItem != null),
        assert(navigatorKey != null);

  final BottomNavigationBarItem bottomNavigationBarItem;
  final GlobalKey<NavigatorState> navigatorKey;
}
