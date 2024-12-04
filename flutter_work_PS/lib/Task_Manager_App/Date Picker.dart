import 'package:flutter/material.dart';

void main() {
  runApp(const DatePics());
}

class DatePics extends StatefulWidget {
  const DatePics({super.key});

  @override
  State<DatePics> createState() => DatePicsState();
}

class DatePicsState extends State<DatePics> {
  // Controller for the TextField to display the selected date
  TextEditingController datesets = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder( // Ensures context is directly available for the date picker
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: datesets, // Connects the controller
                  onTap: () async {
                    // Trigger the date picker when the TextField is tapped
                    await selectDate(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    filled: true,
                  ),
                  readOnly: true, // Prevents manual input
                ),
                ElevatedButton(
                  onPressed: () async {
                    await selectDate(context);
                  },
                  child: const Text("Select Date"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        datesets.text = picked.toString().split(" ")[0]; // Display only the date
      });
    }
  }
}
