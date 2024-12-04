// To parse this JSON data, do
//
//     final strcategory = strcategoryFromJson(jsonString);

import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:get/get.dart';


Strcategory strcategoryFromJson(String str) => Strcategory.fromJson(json.decode(str));
String strcategoryToJson(Strcategory data) => json.encode(data.toJson());

class Strcategory {
  List<Meal> meals;

  Strcategory({
    required this.meals,
  });

  factory Strcategory.fromJson(Map<String, dynamic> json) => Strcategory(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  String strCategory;

  Meal({
    required this.strCategory,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strCategory: json["strCategory"],
  );

  Map<String, dynamic> toJson() => {
    "strCategory": strCategory,
  };
}


//This is the API for fetching data of str category

// Assuming you have the Meal class and strCategoryFromJson function defined elsewhere

Future<RxList<Meal>> fetchstrcategory() async {
  final response = await http.get(Uri.parse("http://www.themealdb.com/api/json/v1/1/list.php?c=list"));
  RxList<Meal> storevalue = <Meal>[].obs; // Changed to RxList<Meal>

  if (response.statusCode == 200) {
    final save = jsonDecode(response.body);
    if (save["meals"] != null) {
      // Map the JSON response to a list of Meal objects
      for (var value in save["meals"]) {
        storevalue.add(Meal.fromJson(value)); // Parse each value into Meal object
      }
    }
    return storevalue;
  } else {
    throw Exception("Value not found");
  }
}
