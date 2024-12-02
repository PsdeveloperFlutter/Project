import 'package:flutter/material.dart';
import 'package:untitled/Document_Scanning_App/Home_Screen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

void main() {
  runApp(MainPage());
}