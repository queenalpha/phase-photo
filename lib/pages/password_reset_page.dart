import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/util/validator.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFD9D9D9),
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color as needed
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class PasswordResetPage extends StatefulWidget {
  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _resetPasswordFormKey = GlobalKey<FormState>();

  final _newPasswordTextController = TextEditingController();
  final _focusEmail = FocusNode();

  @override
  void dispose() {
    _newPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg2.png', // Ganti dengan path gambar latar belakang yang diinginkan
              fit: BoxFit.cover,
            ),
          ),
          // Container Rounded di Bagian Atas
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _resetPasswordFormKey,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/logo2.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Forget Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Enter your registered email address below to reset your password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _newPasswordTextController,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(height: 30),
                          RoundedButton(
                            colour: Colors.black,
                            title: 'Send Email',
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
