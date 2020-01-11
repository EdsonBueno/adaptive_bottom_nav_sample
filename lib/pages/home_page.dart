import 'package:adaptive_bottom_nav_sample/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/indexed_page_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: IndexedStack(
          index: _currentBarIndex,
          children: [
            IndexedPageFlow(flow: appFlows[0]),
            IndexedPageFlow(flow: appFlows[1])
          ],
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
