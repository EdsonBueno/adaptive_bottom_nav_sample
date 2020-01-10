import 'package:adaptive_bottom_nav_sample/app_flow.dart';
import 'package:adaptive_bottom_nav_sample/pages/dummy_page.dart';
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
    ),
    AppFlow(
      title: 'Music',
      iconData: Icons.music_note,
      mainColor: Colors.green,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final currentFlow = appFlows[_currentBarIndex];
    return Scaffold(
      body: DummyPage(
        title: currentFlow.title,
        backgroundColor: currentFlow.mainColor,
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
            _currentBarIndex = newIndex;
          },
        ),
      ),
    );
  }
}
