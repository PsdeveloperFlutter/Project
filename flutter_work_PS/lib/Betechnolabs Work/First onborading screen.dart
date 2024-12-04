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
      home: ShareCarScreen(),
    );
  }
}

class ShareCarScreen extends StatelessWidget {
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
                'assets/car_image.png', // Replace with your image asset path
                height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              // Title
              const Text(
                'Share Car & Carpool',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Easily share your ride or find a ride with just a few steps. Connect with nearby drivers or passengers heading your way and grab a smooth, eco-friendly journey together.',
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
