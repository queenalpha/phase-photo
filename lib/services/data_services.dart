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

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<void> _confirmPasswordReset(ActionCodeInfo link) async {
  //   try {
  //     await FirebaseAuth.instance.confirmPasswordReset(
  //       newPassword: 'new_password', // Obtained from user input
  //     );
  //     // Password reset successful, navigate to login or home screen
  //   } on FirebaseAuthException catch (e) {
  //     // Handle errors appropriately
  //     if (e.code == 'expired-action-code') {
  //       // Inform the user that the link has expired
  //     } else {
  //       // Handle other errors
  //     }
  //   }
  // }
}
