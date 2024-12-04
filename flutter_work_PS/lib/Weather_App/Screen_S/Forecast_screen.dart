// This is the Forecast screen of the weather app
// This screen fetches the data from the api and shows the forecast of the location

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Weather_App/Weather_API/Forecast_api.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ForecastScreen(),
  ));
}
class ForecastScreen extends StatefulWidget {
  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  // This is the api key
  String apiKey = "3ceb0993fafe4b9fb1f90415241811";

  // This is the url of the api
  String url =
      "http://api.weatherapi.com/v1/forecast.json?key=3ceb0993fafe4b9fb1f90415241811&q=London&days=1&aqi=yes&alerts=yes";

  // This is the forecast model
  late Forecast forecast;

  // This is the function to fetch the data from the api
  Future<Forecast> fetchData() async {
    final response = await http.get(Uri.parse(url));

    // If the response is successful, decode the json and return the forecast model
    if (response.statusCode == 200) {
      return Forecast.fromJson(jsonDecode(response.body));
    } else {
      // If the response is not successful, throw an exception
      throw Exception('Failed to load forecast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: Text(
          'Forecast',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Itim',
          ),
        ),
      ),

      body: Center(
        child: FutureBuilder<Forecast>(
          future: fetchData(),
          builder: (context, snapshot) {
            // If the data is loading, show a circular progress indicator
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // If the data is loaded, show the data
              forecast = snapshot.data!;
              return ListView(
                children: [
                  Card(
                    elevation: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ExpansionTile(title: Text("Forecast"), children: [
                          Text(forecast.forecast.forecastday[0].day.condition.text),
                          Text(forecast.forecast.forecastday[0].day.mintempC.toString()),
                          Text(forecast.forecast.forecastday[0].day.maxtempC.toString()),
                          Text(forecast.forecast.forecastday[0].date.toString()),
                        ]),
                        ExpansionTile(title: Text("Location"), children: [
                          Text(forecast.location.name),
                          Text(forecast.location.country),
                        ]),
                        ExpansionTile(title: Text("Current"), children: [
                          Text(forecast.current.tempC.toString()),
                          Text(forecast.current.feelslikeC.toString()),
                          Text(forecast.current.windKph.toString()),
                          Text(forecast.current.windDir),
                          Text(forecast.current.humidity.toString()),
                          Text(forecast.current.cloud.toString()),
                          Text(forecast.current.uv.toString()),
                          Text(forecast.current.pressureMb.toString()),
                          Text(forecast.current.precipIn.toString()),
                          Text(forecast.current.feelslikeF.toString()),
                          Text(forecast.current.precipMm.toString()),
                          Text(forecast.current.condition.text),
                          Image.network("https:"+forecast.current.condition.icon),
                        ]),
                      ],
                    ),
                  )
                ],
              );
            } else {
              // If the data is not loaded, show an error message
              return Text('Error: ${snapshot.error}');
            }
          },
        ),
      ),
    );
  }
}