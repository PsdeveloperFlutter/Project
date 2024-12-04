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

class NewRideScreen extends StatefulWidget {
  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {
  DateTime? _selectedDate; // To store the selected date
  int _personCount = 1; // To track the number of persons

  // Function to show the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Recommended Pricing',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\u{20B9}550.40',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Date of Journey Field
              GestureDetector(
                onTap: () => _selectDate(context),
                child: RideInputField(
                  icon: Icons.calendar_today,
                  label: _selectedDate == null
                      ? 'Date of Journey'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  isNumberInput: false,
                  isReadOnly: true,
                ),
              ),
              // Person Count Field
              RideInputField(
                icon: Icons.person,
                label: '$_personCount Person${_personCount > 1 ? 's' : ''}',
                isNumberInput: true,
                hasIncrementDecrement: true,
                onIncrement: () {
                  setState(() {
                    _personCount++;
                  });
                },
                onDecrement: () {
                  setState(() {
                    if (_personCount > 1) {
                      _personCount--;
                    }
                  });
                },
              ),
              // Desired Fare Field
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
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final bool isReadOnly;

  const RideInputField({
    Key? key,
    required this.icon,
    required this.label,
    this.isNumberInput = false,
    this.hasIncrementDecrement = false,
    this.onIncrement,
    this.onDecrement,
    this.isReadOnly = false,
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
              readOnly: isReadOnly,
              keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
            ),
          ),
          if (hasIncrementDecrement)
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: onIncrement,
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red),
                  onPressed: onDecrement,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
