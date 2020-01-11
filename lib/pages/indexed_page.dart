import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Page that displays it's index, flow's title and color.
// Has a button for pushing another one of it's kind with an incremented index.
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
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndexedPage(
                  index: index + 1,
                  backgroundColor: Colors.amberAccent,
                  containingFlowTitle: containingFlowTitle,
                ),
              ),
            );
          },
          child: const Text('NEXT PAGE'),
        ),
      ),
    );
  }
}
