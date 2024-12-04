import 'dart:async';

import 'package:flutter/material.dart';

import '../screen/Login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 9),(){
      // Navigate to the home screen after a delay
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Loginscreen())
      );
    });
    // Set up the animation controller and animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/instagram.png', // Update this path if needed
                width: 150,
                height: 120,
              ),
              // Spacing between the logo and the Instagram name image
              Image.asset(
                'assets/images/insta.png', // Add the correct path for the uploaded Instagram text logo image
                width: 200, // Adjust width and h eight as necessary
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome to Instagram!')),
    );
  }
}
