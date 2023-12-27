import 'package:flutter/material.dart';
import 'package:phase_photo/configuration/bottomNavigation.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:phase_photo/pages/profile.dart';
import 'package:phase_photo/pages/welcome.dart';
// import 'package:phase_photo/navigation_bar_demo.dart'; // Assuming your NavigationBarDemo is in a separate file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phase Studio',
      home: SplashScreen(), 
      routes: {
        'profile': (context) => const ProfilePage(),
        'home': (context) => const NavigationBarDemo(), 
      },
    );
  }
}
