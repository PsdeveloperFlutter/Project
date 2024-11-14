// To parse this JSON data, do
//
//     final ingredients = ingredientsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
Ingredients ingredientsFromJson(String str) => Ingredients.fromJson(json.decode(str));

String ingredientsToJson(Ingredients data) => json.encode(data.toJson());

class Ingredients {
  List<Meal> meals;

  Ingredients({
    required this.meals,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  String idIngredient;
  String strIngredient;
  String? strDescription;
  String? strType;

  Meal({
    required this.idIngredient,
    required this.strIngredient,
    required this.strDescription,
    required this.strType,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    idIngredient: json["idIngredient"],
    strIngredient: json["strIngredient"],
    strDescription: json["strDescription"],
    strType: json["strType"],
  );

  Map<String, dynamic> toJson() => {
    "idIngredient": idIngredient,
    "strIngredient": strIngredient,
    "strDescription": strDescription,
    "strType": strType,
  };
}


//This is the API which Is Responsible for fetching the data of Ingredients

Future<RxList<dynamic>> fetchingingredients()async{
  final response=await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?i=list"));
  final save =jsonDecode(response.body);
  RxList<dynamic> storevalue=[].obs;
  if(response.statusCode==200){
    if(save["meals"]!=null){
      for(var value in save["meals"]){
        storevalue.add(Meal.fromJson(value));
      }
    }
    return storevalue;
  }
  else {
    throw Exception("The value is not found ");
  }
}