import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MeetAndConnectScreen(),
    );
  }
}

class MeetAndConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                'assets/meet_connect.png', // Replace with your image asset path
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              // Title
              const Text(
                'Meet & Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Empowering you, Meet new friends or peers by discovering meaningful connections, experiences, and broadening your network on the go.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.5, // Line height
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
