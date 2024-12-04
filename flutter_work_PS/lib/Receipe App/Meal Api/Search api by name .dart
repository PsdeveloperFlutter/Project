// To parse this JSON data, do
//
//     final searchmealbyname = searchmealbynameFromJson(jsonString);

//This is the Api for the searching process when the user search a receipe way name so it is search by the help of this below mention code .
import 'dart:convert';
import 'package:http/http.dart' as http; //This is the variable set for the purpose of api fetching
import 'package:get/get.dart';

import 'dart:convert';

Searchmealbyname searchmealbynameFromJson(String str) => Searchmealbyname.fromJson(json.decode(str));

class Searchmealbyname {
  List<dynamic>? meals;

  Searchmealbyname({this.meals});

  factory Searchmealbyname.fromJson(Map<String, dynamic> json) => Searchmealbyname(
    meals: json["meals"] ?? [],
  );
}

//This is the Api function for helping for the searching process with help of name

Future<RxList<dynamic>> searchfunctionbyname(String name) async {
  final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=$name"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    RxList<dynamic> storevalue = [].obs;

    if (data['meals'] != null) {
      for (var value in data['meals']) {
        storevalue.add(value);
      }
    }
    return storevalue;
  } else {
    throw Exception("Failed to Search Value");
  }
}
