import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/firebase_options.dart';
import 'package:phase_photo/configuration/bottomNavigation.dart';
import 'package:phase_photo/pages/forgetpassword.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:phase_photo/pages/login.dart';
import 'package:phase_photo/pages/register.dart';
import 'package:phase_photo/pages/profile.dart';
import 'package:phase_photo/pages/welcome.dart';
// import 'package:phase_photo/navigation_bar_demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => SplashScreen(),
        'forgot_password': (context) => const ForgetPassword(),
        'login': (context) => const Login(),
        // 'home': (context) => const HomePage(),
        'profile': (context) => const ProfilePage(),
        'home': (context) => const NavigationBarDemo(),
      },
    );
  }
}
