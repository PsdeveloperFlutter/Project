//This is the API of the Countries search receipe with help of name of country
import 'dart:convert';
import 'package:http/http.dart' as http;
import'package:get/get.dart';

Searchbycountry searchbycountryFromJson(String str) => Searchbycountry.fromJson(json.decode(str));

String searchbycountryToJson(Searchbycountry data) => json.encode(data.toJson());

class Searchbycountry {
  List<Meal> meals;

  Searchbycountry({
    required this.meals,
  });

  factory Searchbycountry.fromJson(Map<String, dynamic> json) => Searchbycountry(
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



//This Function is Responsible for the SERACHING THE RECEIPE SPECFIC OF COUNTRY
Future <RxList<dynamic>> searchbycountry(var name)async{
  final response =await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?a=$name'));
  final save =jsonDecode(response.body);
  RxList<dynamic> storevalue=[].obs;
  if(response.statusCode==200){
    if(save['meals']!=null){
      for(var value in save['meals']){
       storevalue.add(value);
      }
    }
    return storevalue;
  }
  else{
    throw Exception("Failed to search value ");
  }
}