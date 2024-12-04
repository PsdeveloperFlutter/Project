import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home_Page.dart';
import 'Sign up screen.dart';
import 'UI component .dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function with Firebase
  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Navigate to HomePage after successful login
        Get.to(HomePages());
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred. Please try again.";
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            HomePage(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App Logo or Title
                        Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.mail),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(
                                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$') // Basic email pattern
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            suffixIcon: IconButton(
                              icon: _isObscure
                                  ? Icon(CupertinoIcons.eye)
                                  : Icon(CupertinoIcons.eye_slash),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),

                        // Login Button
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Additional Options (Forgot Password)
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle Forgot Password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to the Sign Up screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
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
        ));
  }
}
