import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UI component .dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign-up function with Firebase
  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create a new user with Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // After successful sign-up, show a success message and navigate to the login page (or home)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.pop(context); // Go back to the login page or main screen
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred. Please try again.";
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The email is already in use by another account.';
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
                        'Create Your Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 30),

                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Surname Field
                      TextFormField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.person),
                          labelText: 'Surname',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your surname';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

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

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Additional Options (Login)
                      TextButton(
                        onPressed: () {
                          // Navigate back to login page
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Already have an account? Log in',
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
