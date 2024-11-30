import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewRideScreen(),
    );
  }
}

class NewRideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'New Ride',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'),
                      radius: 24,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jhon Doe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Block-A, Mondeal Square, Prahlad Nagar,\nAhmedabad, Gujarat 380015, India',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Block-B, Mondeal Square, Prahlad Nagar,\nAhmedabad, Gujarat 380015, India',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Pricing Section
              const Text(
                'Recommended Pricing',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '\u{20B9}550.40',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 16),
              // Input Fields
              const RideInputField(
                icon: Icons.calendar_today,
                label: 'Date of Journey',
                isNumberInput: false,
              ),
              const RideInputField(
                icon: Icons.person,
                label: '1 Person',
                isNumberInput: true,
                hasIncrementDecrement: true,
              ),
              const RideInputField(
                icon: Icons.attach_money,
                label: 'Desired Fare',
                isNumberInput: true,
              ),
              const SizedBox(height: 24),
              // Continue Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideInputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isNumberInput;
  final bool hasIncrementDecrement;

  const RideInputField({
    Key? key,
    required this.icon,
    required this.label,
    this.isNumberInput = false,
    this.hasIncrementDecrement = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: label,
                border: const UnderlineInputBorder(),
              ),
              keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
            ),
          ),
          if (hasIncrementDecrement)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}
