import 'package:flutter/material.dart';
import 'package:phase_photo/configuration/bottomNavigation.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:phase_photo/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash Screen',
      initialRoute: 'home',
      routes: {
        'home': (context) => const NavigationBarDemo(),
        'profile': (context) => const ProfilePage(),
      },
    );
  }
}
