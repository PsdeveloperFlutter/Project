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
      home: SaveFuelCostsScreen(),
    );
  }
}

class SaveFuelCostsScreen extends StatelessWidget {
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
                'assets/save_fuel_costs.png', // Replace with your image asset path
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              // Title
              const Text(
                'Save Fuel Costs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Reduce your fuel expenses by sharing rides. Carpooling helps you save money, lower your carbon footprint, and travel more efficiently.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.5, // Line height for better readability
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
