import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({
    @required this.title,
    @required this.backgroundColor,
    Key key,
  })  : assert(title != null),
        assert(backgroundColor != null),
        super(key: key);

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            title,
            maxLines: 1,
          ),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {},
            child: const Text('Next Page'),
          ),
        ),
      );
}
