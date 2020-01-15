import 'package:adaptive_bottom_nav_sample/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/indexed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Contains our different pages flows and bottom navigation menu for
/// alternating between them.
///
/// It's called Screen — not Page — to avoid confusion, this one displays
/// Pages inside it.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Video',
      iconData: Icons.ondemand_video,
      mainColor: Colors.red,
      navigatorKey: GlobalKey(),
    ),
    AppFlow(
      title: 'Music',
      iconData: Icons.music_note,
      mainColor: Colors.green,
      navigatorKey: GlobalKey(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final currentFlow = appFlows[_currentBarIndex];

    // We're preventing the root navigator from popping and closing the
    // app if the inner navigator can handle it, which occurs when it has
    // more than one screen on it's stack. You can comment the onWillPop
    // callback and watch it happening.
    return WillPopScope(
      onWillPop: () async =>
          !await currentFlow.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: Navigator(
          // The key in necessary for two reasons:
          // 1 - For the framework to understand that we're replacing the
          // navigator even though it's type and location in the tree is
          // the same. For this isolate purpose a simple ValueKey would fit.
          // 2 - Being able to access the Navigator's state inside the onWillPop
          // callback and for emptying it's stack when a tab is re-selected.
          // That is why a GlobalKey is needed instead of a simple ValueKey.
          key: currentFlow.navigatorKey,
          // Since this isn't the purpose of this sample, we're not using named
          // routes, because of that the onGenerateRoute callback will be
          // called only for the initial route.
          onGenerateRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (context) => IndexedPage(
              index: 1,
              containingFlowTitle: currentFlow.title,
              backgroundColor: currentFlow.mainColor,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBarIndex,
          items: appFlows
              .map(
                (flow) => BottomNavigationBarItem(
                  title: Text(flow.title),
                  icon: Icon(flow.iconData),
                ),
              )
              .toList(),
          onTap: (newIndex) => setState(
            () {
              if (_currentBarIndex != newIndex) {
                _currentBarIndex = newIndex;
              } else {
                // If the user is re-selecting the tab, the common
                // behavior is to empty the stack.
                currentFlow.navigatorKey.currentState
                    .popUntil((route) => route.isFirst);
              }
            },
          ),
        ),
      ),
    );
  }
}
