// To parse this JSON data, do
//
//     final selectionofcategory = selectionofcategoryFromJson(jsonString);

import 'dart:convert';
import'package:http/http.dart'as http;
import'package:get/get.dart';
Selectionofcategory selectionofcategoryFromJson(String str) => Selectionofcategory.fromJson(json.decode(str));

String selectionofcategoryToJson(Selectionofcategory data) => json.encode(data.toJson());

class Selectionofcategory {
  List<Meal> meals;

  Selectionofcategory({
    required this.meals,
  });

  factory Selectionofcategory.fromJson(Map<String, dynamic> json) => Selectionofcategory(
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









//This is the API for Responsible for fetching the data
Future<RxList<dynamic>>selectionofcategory(var value)async{
  final response=await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$value"));
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
  else{
    throw Exception("Value is not found ");
  }
}