import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MaterialBottomNavigationScaffold extends StatelessWidget {
  const MaterialBottomNavigationScaffold({
    @required this.navigationBarItems,
    @required this.onItemSelected,
    @required this.selectedIndex,
    @required this.initialPageBuilder,
    Key key,
  })  : assert(navigationBarItems != null),
        assert(onItemSelected != null),
        assert(selectedIndex != null),
        assert(initialPageBuilder != null),
        super(key: key);

  final List<NavigationBarItem> navigationBarItems;
  final void Function(int value) onItemSelected;
  final int selectedIndex;
  final Widget Function(int value) initialPageBuilder;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [
            _buildPageFlow(context, 0),
            _buildPageFlow(context, 1),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            items: navigationBarItems
                .map(
                  (item) => item.bottomNavigationBarItem,
                )
                .toList(),
            onTap: onItemSelected),
      );

  Widget _buildPageFlow(BuildContext context, int tabIndex) {
    final barItem = navigationBarItems[tabIndex];
    return Navigator(
      // The key enables us to access the Navigator's state inside the
      // onWillPop callback and for emptying it's stack when a tab is
      // re-selected. That is why a GlobalKey is needed instead of
      // a simpler ValueKey.
      key: barItem.navigatorKey,
      // Since this isn't the purpose of this sample, we're not using named
      // routes, because of that the onGenerateRoute callback will be
      // called only for the initial route.
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (context) => initialPageBuilder(tabIndex),
      ),
    );
  }
}
