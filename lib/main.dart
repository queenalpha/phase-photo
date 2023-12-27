import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phase_photo/pages/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.zero,
          //child: SingleChildScrollView(
          child: AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'LogoPhase-2.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.contain,
                ),
                const Text(
                  'PHASE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 220),
                const Text(
                  'V.0.1',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            nextScreen: const MyHomePage(title: 'home'),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            duration: 1000,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      //),
    );
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedSplashScreen(
//           splash: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'LogoPhase-2.png',
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 fit: BoxFit.contain,
//               ),
//               const Text(
//                 "PHASE",
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 100),
//               const Text(
//                 "V.0.1",
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           nextScreen: const MyHomePage(title: 'home'),
//           splashTransition: SplashTransition.fadeTransition,
//           pageTransitionType: PageTransitionType.fade,
//           duration: 1000,
//           backgroundColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
