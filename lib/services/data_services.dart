import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DataServices {
  Future<User?> registerUserWithEmailPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Set the display name
      await userCredential.user!.updateDisplayName(displayName);
      print('User registered successfully with display name: $displayName');
      return userCredential.user;
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }
}
