import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RideScreen(),
    );
  }
}

class RideScreen extends StatefulWidget {
  @override
  _RideScreenState createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  DateTime? selectedDate;
  int personCount = 1;
  int currentIndex = 0;

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Rides",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "My Rides",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                    ),
                    child: const Text(
                      "Published",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Column(
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile.png'),
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
                              SizedBox(height: 4),
                              Text(
                                '10:00 AM\nBlock-A, Mondeal Square, Prahlad Nagar, Ahmedabad',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '11:00 AM\nBlock-B, Mondeal Square, Prahlad Nagar, Ahmedabad',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(
                            "Active",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                              : "Tue, 1st Jan 20",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹900",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Center(
                  child: Text(
                    "Track Ride",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.green),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: "Rides",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User",
          ),
        ],
      ),
    );
  }
}
