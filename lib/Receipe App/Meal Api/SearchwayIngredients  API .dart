// To parse this JSON data, do
//
//     final searchwayIngredients = searchwayIngredientsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
SearchwayIngredients searchwayIngredientsFromJson(String str) => SearchwayIngredients.fromJson(json.decode(str));

String searchwayIngredientsToJson(SearchwayIngredients data) => json.encode(data.toJson());

class SearchwayIngredients {
  List<Meal> meals;

  SearchwayIngredients({
    required this.meals,
  });

  factory SearchwayIngredients.fromJson(Map<String, dynamic> json) => SearchwayIngredients(
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





//This is the function is Responsible for the Fetching the Recipe with Ingredients

Future<RxList<dynamic>>searchIngredients(var name) async{
  final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?i=$name"));
  final save=jsonDecode(response.body);
  RxList<dynamic> storevalue=[].obs;
  if(response.statusCode==200){
    if(save["meals"]!=null){
      for(var value in save["meals"]){
        storevalue.add(Meal.fromJson(value));
      }
    }
    return storevalue;
  }
  else{
    throw Exception("Value is not found");
  }
}
