import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/pages/register.dart';
import 'package:phase_photo/services/data_services.dart';
import 'package:phase_photo/util/validator.dart';

import '../configuration/textField.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _dataService = DataServices();

  final _loginFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _loginFormKey,
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
                          TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value,
                            ),
                            decoration: costumeTextField.copyWith(
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            obscureText: !_isPasswordVisible,
                            validator: (value) => Validator.validatePassword(
                              password: value,
                            ),
                            decoration: costumeTextField.copyWith(
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              hintText: "Password",
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'forgot_password');
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          RoundedButton(
                            colour: Colors.black,
                            title: 'Sign In',
                            textColor: Colors.white,
                            onPressed: () async {
                              if (_loginFormKey.currentState!.validate()) {
                                try {
                                  User? user = await _dataService
                                      .signInWithEmailAndPassword(
                                          _emailTextController.text,
                                          _passwordTextController.text);

                                  if (user != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Login success'),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, 'home');
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'invalid-credential') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Login failed: User not found or Wrong Password'),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Login failed: Error ${e.code}'),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Doesn\'t Have Account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Register();
                                      }));
                                    },
                                    child: const Text(
                                      ' Register Here',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
