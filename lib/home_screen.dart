import 'package:adaptive_bottom_nav_sample/custom/adaptive_bottom_navigation_scaffold.dart';
import 'package:adaptive_bottom_nav_sample/custom/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/custom/bottom_navigation_tab.dart';
import 'package:adaptive_bottom_nav_sample/indexed_page.dart';
import 'package:flutter/cupertino.dart';
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
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Video',
      iconData: Icons.ondemand_video,
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Music',
      iconData: Icons.music_note,
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    )
  ];

  @override
  Widget build(BuildContext context) => AdaptiveBottomNavigationScaffold(
        navigationBarItems: appFlows
            .map(
              (flow) => BottomNavigationTab(
                  bottomNavigationBarItem: BottomNavigationBarItem(
                    label: flow.title,
                    icon: Icon(flow.iconData),
                  ),
                  navigatorKey: flow.navigatorKey,
                  initialPageBuilder: (context) => IndexedPage(
                        index: 1,
                        backgroundColor: flow.mainColor,
                        containingFlowTitle: flow.title,
                      )),
            )
            .toList(),
      );
}
