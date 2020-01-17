import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Page that displays it's index, flow's title and color.
///
/// Has a button for pushing another one of it's kind with an incremented index,
///  and another button for starting a new flow named 'New' with
/// a random background color.
class IndexedPage extends StatelessWidget {
  const IndexedPage({
    @required this.index,
    @required this.backgroundColor,
    @required this.containingFlowTitle,
    Key key,
  })  : assert(index != null),
        assert(backgroundColor != null),
        super(key: key);

  final int index;
  final Color backgroundColor;
  final String containingFlowTitle;

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Page $index';
    if (containingFlowTitle != null) {
      pageTitle += ' of $containingFlowTitle Flow';
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          pageTitle,
          maxLines: 1,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Horizontally pushes a new screen.
            RaisedButton(
              onPressed: () {
                _pushPage(context, true);
              },
              child: const Text('NEXT PAGE (HORIZONTALLY)'),
            ),

            // Vertically pushes a new screen / Starts a new flow.
            // In a real world scenario, this could be an authentication flow
            // where the user can choose to sign in or sign up.
            RaisedButton(
              onPressed: () {
                _pushPage(context, false);
              },
              child: const Text('NEXT FLOW (VERTICALLY)'),
            ),
          ],
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, bool isHorizontalNavigation) {
    // If it's not a horizontal navigation,
    // we should use the rootNavigator.
    Navigator.of(context, rootNavigator: !isHorizontalNavigation).push(
      _buildAdaptivePageRoute(
        builder: (context) => IndexedPage(
          // If it's a new flow, the displayed index should be 1 again.
          index: isHorizontalNavigation ? index + 1 : 1,
          // If it's a new flow, we'll randomize it's color.
          backgroundColor: isHorizontalNavigation
              ? backgroundColor
              : Colors.primaries[Random().nextInt(Colors.primaries.length)],
          // If it's stating a new flow let's just call it 'New.'
          containingFlowTitle:
              isHorizontalNavigation ? containingFlowTitle : 'New',
        ),
        fullscreenDialog: !isHorizontalNavigation,
      ),
    );
  }

  // Flutter will use the fullscreenDialog property to change the animation
  // and the app bar's left icon to an X instead of an arrow.
  PageRoute<T> _buildAdaptivePageRoute<T>({
    @required WidgetBuilder builder,
    bool fullscreenDialog = false,
  }) =>
      Platform.isAndroid
          ? MaterialPageRoute(
              builder: builder,
              fullscreenDialog: fullscreenDialog,
            )
          : CupertinoPageRoute(
              builder: builder,
              fullscreenDialog: fullscreenDialog,
            );
}
