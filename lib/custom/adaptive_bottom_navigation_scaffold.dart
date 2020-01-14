import 'dart:io';

import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_tab.dart';
import 'package:adaptive_bottom_nav_sample/custom/cupertino_bottom_navigation_scaffold.dart';
import 'package:adaptive_bottom_nav_sample/custom/material_bottom_navigation_scaffold.dart';
import 'package:flutter/widgets.dart';

class AdaptiveBottomNavigationScaffold extends StatefulWidget {
  const AdaptiveBottomNavigationScaffold({
    @required this.navigationBarItems,
    @required this.initialPageBuilder,
    Key key,
  })  : assert(navigationBarItems != null),
        assert(initialPageBuilder != null),
        super(key: key);

  final List<BottomNavigationTab> navigationBarItems;
  final Widget Function(int value) initialPageBuilder;

  @override
  _AdaptiveBottomNavigationScaffoldState createState() =>
      _AdaptiveBottomNavigationScaffoldState();
}

class _AdaptiveBottomNavigationScaffoldState
    extends State<AdaptiveBottomNavigationScaffold> {
  int _currentlySelectedIndex = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        // We're preventing the root navigator from popping and closing the
        // app if the inner navigator can handle it, which occurs when it has
        // more than one screen on it's stack. You can comment the onWillPop
        // callback and watch it happening.
        onWillPop: () async => !await widget
            .navigationBarItems[_currentlySelectedIndex]
            .navigatorKey
            .currentState
            .maybePop(),
        child: Platform.isAndroid
            ? _buildMaterial(context)
            : _buildCupertino(context),
      );

  Widget _buildCupertino(BuildContext context) =>
      CupertinoBottomNavigationScaffold(
        navigationBarItems: widget.navigationBarItems,
        onItemSelected: onTabSelected,
        initialPageBuilder: widget.initialPageBuilder,
      );

  Widget _buildMaterial(BuildContext context) =>
      MaterialBottomNavigationScaffold(
        navigationBarItems: widget.navigationBarItems,
        onItemSelected: onTabSelected,
        initialPageBuilder: widget.initialPageBuilder,
        selectedIndex: _currentlySelectedIndex,
      );

  void onTabSelected(int newIndex) {
    if (_currentlySelectedIndex == newIndex) {
      // If the user is re-selecting the tab, the common
      // behavior is to empty the stack.
      widget.navigationBarItems[newIndex].navigatorKey.currentState
          .popUntil((route) => route.isFirst);
    }

    if (Platform.isAndroid) {
      setState(() {
        _currentlySelectedIndex = newIndex;
      });
    } else {
      _currentlySelectedIndex = newIndex;
    }
  }
}
