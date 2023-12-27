import 'package:firebase_auth/firebase_auth.dart';

class DataServices {
  Future<UserCredential?> registerUserWithEmailPassword(
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
      return userCredential;
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  Future<void> dummyMethod() async {
    print('hello');
  }
}
