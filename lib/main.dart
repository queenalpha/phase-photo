import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/firebase_options.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:phase_photo/pages/login.dart';
import 'package:phase_photo/pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'register': (context) => Register(),
        'login': (context) => Login(),
        'home': (context) => MyHomePage(),
      },
    );
  }
}
