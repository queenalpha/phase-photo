import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/pages/login.dart';
import 'package:phase_photo/services/data_services.dart';
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

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _registerFormKey = GlobalKey<FormState>();
  final _dataService = DataServices();

  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

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
              'assets/bg1.png',
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1C29),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _registerFormKey,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/logo1.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _usernameTextController,
                            focusNode: _focusName,
                            validator: (value) => Validator.validateName(
                              name: value,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xFF1A1C29),
                              ),
                              hintText: "Username",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailTextController,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF1A1C29),
                              ),
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: !_isPasswordVisible,
                            controller: _passwordTextController,
                            focusNode: _focusPassword,
                            validator: (value) => Validator.validatePassword(
                              password: value,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Color(0xFF1A1C29),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF1A1C29),
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              hintText: "Password",
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            obscureText: !_isPasswordVisible,
                            controller: _confirmPasswordTextController,
                            focusNode: _focusConfirmPassword,
                            validator: (value) {
                              if (value != _passwordTextController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Color(0xFF1A1C29),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF1A1C29),
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              hintText: "Confirm Password",
                            ),
                          ),
                          const SizedBox(height: 50),
                          RoundedButton(
                            colour: Colors.white,
                            title: 'Sign Up',
                            textColor: Colors.black,
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                try {
                                  final newUser = await _dataService
                                      .registerUserWithEmailPassword(
                                    _emailTextController.text,
                                    _passwordTextController.text,
                                    _usernameTextController.text,
                                  );

                                  if (newUser != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'User successfully registered'),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, 'home');
                                  }
                                } catch (e) {
                                  print(e.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to register new user: $e'),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already Have Account?',
                                style: TextStyle(
                                  color: Colors.white,
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
                                        return Login();
                                      }));
                                    },
                                    child: const Text(
                                      ' Login Now',
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
