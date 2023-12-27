import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/pages/register.dart';
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

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _emailTextController = TextEditingController();
  final _PassswordTextController = TextEditingController();

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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                      decoration: kTextFieldDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _PassswordTextController,
                      focusNode: _focusPassword,
                      obscureText: !_isPasswordVisible,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: kTextFieldDecoration.copyWith(
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
                    const SizedBox(height: 50),
                    RoundedButton(
                      colour: Colors.black,
                      title: 'Sign Up',
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Doesn\'t Have Account?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 4),
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
                              child: Text(
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
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
