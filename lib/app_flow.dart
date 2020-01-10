import 'package:flutter/widgets.dart';

class AppFlow {
  const AppFlow({
    @required this.title,
    @required this.mainColor,
    @required this.iconData,
  })  : assert(title != null),
        assert(mainColor != null),
        assert(iconData != null);

  final String title;
  final Color mainColor;
  final IconData iconData;
}
