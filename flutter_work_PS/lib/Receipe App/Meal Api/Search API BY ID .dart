import 'dart:convert';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


Searchbyid searchbyidFromJson(String str) =>
    Searchbyid.fromJson(json.decode(str));

String searchbyidToJson(Searchbyid data) => json.encode(data.toJson());

class Searchbyid {
  List<Map<String, String?>> meals;

  Searchbyid({
    required this.meals,
  });

  factory Searchbyid.fromJson(Map<String, dynamic> json) => Searchbyid(
    meals: List<Map<String, String?>>.from(json["meals"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}




Future<RxList<dynamic>> searchbyID(int name) async {
  final response = await http
      .get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$name"));
  final save = jsonDecode(response.body);
  RxList<dynamic> storeValue = <dynamic>[].obs;

  if (response.statusCode == 200) {
    if (save['meals'] != null) {
      for (var value in save["meals"]) {
        storeValue.add(value);
      }
      return storeValue;
    }
  }
  throw Exception("The value is not found");
}
