// To parse this JSON data, do
//
//     final filterbycategories = filterbycategoriesFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
Filterbycategories filterbycategoriesFromJson(String str) => Filterbycategories.fromJson(json.decode(str));

String filterbycategoriesToJson(Filterbycategories data) => json.encode(data.toJson());

class Filterbycategories {
  List<Meal> meals;

  Filterbycategories({
    required this.meals,
  });

  factory Filterbycategories.fromJson(Map<String, dynamic> json) => Filterbycategories(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strMeal: json["strMeal"],
    strMealThumb: json["strMealThumb"],
    idMeal: json["idMeal"],
  );

  Map<String, dynamic> toJson() => {
    "strMeal": strMeal,
    "strMealThumb": strMealThumb,
    "idMeal": idMeal,
  };
}










// This is the API of the Fetching Meal Related to Categories

Future<RxList<dynamic>>fetchingcategories(var name)async{
  final response= await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$name"));
  final save=jsonDecode(response.body);
  RxList<dynamic>storevalue=[].obs;
  if(response.statusCode==200){
    if(save["meals"]!=null){
      for(var value in save["meals"]){
        storevalue.add(Meal.fromJson(value));
      }
    }
    return storevalue;
  }
  else
    {
      throw Exception("The value is not found ");
    }
}

