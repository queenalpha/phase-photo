import 'package:phase_photo/pages/add_photo.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:phase_photo/pages/profile.dart';
import 'package:flutter/material.dart';

class NavigationBarDemo extends StatefulWidget {
  const NavigationBarDemo({Key? key}) : super(key: key);

  @override
  _NavigationBarDemoState createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<NavigationBarDemo> {
  int _currentIndex = 0;

  final List<Widget> _page = const [
    HomePage(),
    CreatePhoto(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            label: 'Create History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.grey[400],
        unselectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
