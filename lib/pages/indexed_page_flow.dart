import 'package:adaptive_bottom_nav_sample/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/pages/indexed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Just a wrapper around a Navigator that has an IndexedPage
// as it's initial route.
class IndexedPageFlow extends StatelessWidget {
  const IndexedPageFlow({
    @required this.flow,
    Key key,
  })  : assert(flow != null),
        super(key: key);

  final AppFlow flow;

  @override
  Widget build(BuildContext context) => Navigator(
        // The key enables us to access the Navigator's state inside the
        // onWillPop callback and for emptying it's stack when a tab is
        // re-selected. That is why a GlobalKey is needed instead of
        // a simpler ValueKey.
        key: flow.navigatorKey,
        // Since this isn't the purpose of this sample, we're not using named
        // routes, because of that the onGenerateRoute callback will be
        // called only for the initial route.
        onGenerateRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => IndexedPage(
            index: 1,
            containingFlowTitle: flow.title,
            backgroundColor: flow.mainColor,
          ),
        ),
      );
}
