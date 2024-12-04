import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ImagePicker imagePicker;
  XFile? selectedImage; // Store the selected image

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  Future<void> pickImageFromGallery() async {
    // Request permissions dynamically
    var permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      try {
        XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            selectedImage = image; // Update the state with the selected image
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Permission denied!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40, bottom: 15, left: 5, right: 5),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildIconColumn(Icons.scanner_outlined, "Scan"),
                  buildIconColumn(Icons.document_scanner, "Recognize"),
                  buildIconColumn(Icons.assignment_sharp, "Enhance"),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height - 250,
              child: selectedImage != null
                  ? Image.file(File(selectedImage!.path)) // Display selected image
                  : Center(
                child: Text(
                  "No Image Selected",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.rotate_left, size: 35, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera, size: 50, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: pickImageFromGallery,
                    icon: Icon(Icons.image_outlined, size: 35, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildIconColumn(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 25, color: Colors.white),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
