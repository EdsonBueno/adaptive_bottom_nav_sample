import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CupertinoBottomNavigationScaffold extends StatelessWidget {
  const CupertinoBottomNavigationScaffold({
    @required this.navigationBarItems,
    @required this.onItemSelected,
    @required this.initialPageBuilder,
    Key key,
  })  : assert(navigationBarItems != null),
        assert(onItemSelected != null),
        assert(initialPageBuilder != null),
        super(key: key);

  final List<NavigationBarItem> navigationBarItems;
  final void Function(int value) onItemSelected;
  final Widget Function(int value) initialPageBuilder;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        controller: CupertinoTabController(),
        tabBar: CupertinoTabBar(
          items: navigationBarItems
              .map(
                (item) => item.bottomNavigationBarItem,
              )
              .toList(),
          onTap: onItemSelected,
        ),
        tabBuilder: (context, index) => CupertinoTabView(
          navigatorKey: navigationBarItems[index].navigatorKey,
          onGenerateRoute: (settings) => CupertinoPageRoute(
            settings: settings,
            builder: (context) => initialPageBuilder(index),
          ),
        ),
      );
}
