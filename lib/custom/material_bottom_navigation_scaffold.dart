import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A Scaffold with a configured BottomNavigationBar, separate
/// Navigators for each tab view and state retaining across tab switches.
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

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<BottomNavigationTab> navigationBarItems;

  /// Called when a tab selection occurs.
  final void Function(int value) onItemSelected;

  /// Builds the initial page's widget for the given tab index.
  final Widget Function(int value) initialPageBuilder;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
        // The IndexedStack is what allows us to retain state across tab
        // switches by keeping our views in the widget tree while only showing
        // the selected one.
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

  // The best practice here would be to extract this to another Widget,
  // however, moving it to a separate class would only harm the
  // readability of our guide.
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
