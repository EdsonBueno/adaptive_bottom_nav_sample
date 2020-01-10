import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBarIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBarIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.ondemand_video,
              ),
              title: Text(
                'Videos',
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.music_note,
              ),
              title: Text(
                'Musics',
              ),
            )
          ],
          onTap: (newIndex) => setState(
            () {
              _currentBarIndex = newIndex;
            },
          ),
        ),
      );
}
