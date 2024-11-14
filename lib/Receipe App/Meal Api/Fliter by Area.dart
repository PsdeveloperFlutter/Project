//This is the API Filter by area

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
Strarea strareaFromJson(String str) => Strarea.fromJson(json.decode(str));

String strareaToJson(Strarea data) => json.encode(data.toJson());

class Strarea {
  List<Meal> meals;

  Strarea({
    required this.meals,
  });

  factory Strarea.fromJson(Map<String, dynamic> json) => Strarea(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  String strArea;

  Meal({
    required this.strArea,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    strArea: json["strArea"],
  );

  Map<String, dynamic> toJson() => {
    "strArea": strArea,
  };
}


//This is the API OF THE filterbyarea

Future<RxList<dynamic>>filterbyarea() async{
  final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?a=list"));
  final save=jsonDecode(response.body);
  RxList<dynamic> storevalue=[].obs;
  if(response.statusCode==200){
    if(save["meals"]!=200){
      for(var value in save["meals"]){
        storevalue.add(Meal.fromJson(value));
      }
    }
  return storevalue;
  }
  else{
    throw Exception("The value is not found ");
  }
}