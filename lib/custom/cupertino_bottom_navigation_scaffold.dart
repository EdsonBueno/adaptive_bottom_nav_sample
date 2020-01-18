import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CupertinoBottomNavigationScaffold extends StatelessWidget {
  const CupertinoBottomNavigationScaffold({
    @required this.navigationBarItems,
    @required this.onItemSelected,
    @required this.initialPageBuilder,
    @required this.selectedIndex,
    Key key,
  })  : assert(navigationBarItems != null),
        assert(onItemSelected != null),
        assert(initialPageBuilder != null),
        assert(selectedIndex != null),
        super(key: key);

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<BottomNavigationTab> navigationBarItems;

  /// Called when a tab selection occurs.
  final void Function(int value) onItemSelected;

  /// Builds the initial page's widget for the given tab index.
  final Widget Function(int value) initialPageBuilder;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        // As we're managing the selected index outside, there's no need
        // to make this Widget stateful. We just need pass the selectedIndex to
        // the controller every time the widget is rebuilt.
        controller: CupertinoTabController(initialIndex: selectedIndex),
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
