import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cab Finder UI',
      home: CabFinderHomePage(),
    );
  }
}

class CabFinderHomePage extends StatefulWidget {
  @override
  _CabFinderHomePageState createState() => _CabFinderHomePageState();
}

class _CabFinderHomePageState extends State<CabFinderHomePage> {
  int personCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan.withAlpha(50),
        toolbarHeight: 50,
      ),
      body: Column(
        children: [
          // Image section at the top
          ClipRRect(
            child: Container(
              margin: EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/car image.png'), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Form section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Start Position TextField
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Start Position',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // End Position TextField
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'End Position',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Date Picker
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'DD/MM/YYYY',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: _selectDate,
                    ),
                    SizedBox(height: 15),
                    // Person Count Selector
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withAlpha(100)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$personCount Person${personCount > 1 ? 's' : ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: Colors.red.withAlpha(255),
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            personCount++;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: Colors.green,
                                    child: Center(
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (personCount > 1) personCount--;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Find Cabs Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Find Cabs',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Navigation Bar
          BottomNavigationBar(
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.black,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.directions_car),
                label: 'Rides',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Wallet',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to select date using date picker
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // Update your TextField's value or state here
    }
  }
}
