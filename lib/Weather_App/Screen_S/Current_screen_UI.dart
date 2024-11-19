import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/Weather_App/Weather_API/Current_API.dart';

import 'Background_custom_Animation .dart';

TextEditingController searchController = TextEditingController();



// Function to fetch current weather data based on a location
Future<CurrentLocation> fetchCurrentData(String location) async {
  final response = await http.get(Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=3ceb0993fafe4b9fb1f90415241811&q=$location&aqi=no'));

  if (response.statusCode == 200) {
    return CurrentLocation.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load data");
  }
}

// UI Screen
class CurrentScreen extends StatefulWidget {
  final String city;

  CurrentScreen({required this.city});
  @override

  CurrentScreenState createState() => CurrentScreenState();
}

class CurrentScreenState extends State<CurrentScreen> {



  Future<CurrentLocation>? _currentWeatherData;

  @override
  void initState() {
    super.initState();
    _currentWeatherData = fetchCurrentData(widget.city); // Default location
  }

  Offset _position = Offset(250, 500); // Initial position of the FAB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [

          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: Draggable(
              feedback: FloatingActionButton(
                onPressed: null, // No functionality during drag
                backgroundColor: Colors.blue.shade700,
                child: const Icon(
                  size: 30,
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (searchController.text.isNotEmpty) {
                      _currentWeatherData = fetchCurrentData(searchController.text);
                    }
                  });
                },
                backgroundColor: Colors.blue.shade700,
                child: const Icon(
                  size: 30,
                  Icons.search,
                  color: Colors.white,
                ),
                heroTag: "searchButton", // Unique tag for each button
              ),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                // Ensure the button stays within screen bounds
                setState(() {
                  final screenSize = MediaQuery.of(context).size;
                  final adjustedX = details.offset.dx.clamp(0.0, screenSize.width - 56.0); // 56.0 is the FAB diameter
                  final adjustedY = details.offset.dy.clamp(0.0, screenSize.height - 56.0);
                  _position = Offset(adjustedX, adjustedY);
                });
              },
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _currentWeatherData = fetchCurrentData("Panipat");
                });
              },
              backgroundColor: Colors.blue.shade700,
              child: const Icon(
                size: 30,
                Icons.refresh,
                color: Colors.white,
              ),
              heroTag: "refreshButton", // Unique tag for each button
            ),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Current Weather",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Stack(
        children: [
          HomePage(),
          FutureBuilder<CurrentLocation>(
            future: _currentWeatherData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                final currentLocation = snapshot.data!;
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SizedBox(
                      height: 62,
                    ),
                    ListTile(
                      title: Text(
                        "Location: ${currentLocation.location.name}, ${currentLocation.location.country}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Region: ${currentLocation.location.region}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Temperature: ${currentLocation.current.tempC} °C",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Feels Like: ${currentLocation.current.feelslikeC} °C",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Wind: ${currentLocation.current.windKph} kph",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Direction: ${currentLocation.current.windDir}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Humidity: ${currentLocation.current.humidity}%",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "UV Index: ${currentLocation.current.uv}",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Itim',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              }
              return Center(child: Text("No data available"));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                hintText: "Search for a location",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
