import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataServices {
  final imageCollection = FirebaseFirestore.instance.collection('images');

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

  Future<DocumentReference?> addImage(dynamic data) async {
    DocumentReference? addedDocument = null;
    try {
      addedDocument = await imageCollection.add(data);
      return addedDocument;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return addedDocument;
    }
  }

  Future<List<DocumentSnapshot>> getAllImages() async {
    try {
      var imagesSnapshot = await imageCollection.get();
      if (kDebugMode) {
        print(imagesSnapshot.docs.length);
      }
      return imagesSnapshot.docs;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
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
