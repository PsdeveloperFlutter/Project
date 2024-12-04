import 'RecipeDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchbyfirstletter extends StatefulWidget {

  @override
  State<searchbyfirstletter> createState() => _searchbyfirstletterState();
}

var meal;
class _searchbyfirstletterState extends State<searchbyfirstletter> {
  void initState(){
    super.initState();
    searchbyfl("a");
  }
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Receipe by First Name ",
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.black,
              ),
              hintStyle: TextStyle(fontSize: 13, color: Colors.black),
              contentPadding: EdgeInsets.all(4.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future:searchbyfl(searchController.text.trim().toString()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Please enter value",style: TextStyle(fontFamily: 'Itim'),));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Recipe not found",style: TextStyle(fontFamily: 'Itim'),));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      meal = snapshot.data![index];
                      return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Card(
                                elevation: 5,
                                child: Container(
                                    height: 170,
                                    width: 250,
                                    child: Image.network(
                                      "${meal["strMealThumb"]}",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            SizedBox(height: 12,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Food Name :- ",),
                                  Text("${meal['strMeal']}",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Itim')),
                                ],
                              ),
                            ),
                            SizedBox(height: 8,),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Country Dish ',
                                    style: TextStyle(color: Colors.black, fontSize: 17,fontFamily: 'Itim'),
                                  ),
                                  TextSpan(
                                    text: meal["strArea"],
                                    style: TextStyle(fontFamily: 'Itim',color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12,),
                                  const Text("Receipe",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Itim'),),
                                  const SizedBox(height: 2,),
                                  Text("${meal["strInstructions"]}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15,fontFamily: 'Itim'),),
                                ],
                              ),
                            ),


                            // This is the Function which is the Responsible for the Ingredient of the Food

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                           //When the User Press on it so it Navigate to another Screen

                                     Navigator.push(context, MaterialPageRoute(builder: (_)=> Recipedetails(values:meal['strMeal'])));

                                    }, child: Text("More Details",style: TextStyle(fontFamily: 'Itim'))),




                              IconButton(onPressed: (){
                                dbobject
                                    .addrecipe(
                                    snapshot.data![index]["strMeal"],
                                    snapshot.data![index]["strArea"],
                                    snapshot.data![index]["strInstructions"],
                                    snapshot.data![index]["strMealThumb"])
                                    .then((_) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor:
                                      Colors.blue.shade700,
                                      content: Text(
                                          "Recipe has saved "), // Customize the message
                                      duration: Duration(seconds: 1),
                                    )));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text("Recipe has Saved"),
                                    backgroundColor: Colors.blue.shade700,
                                  ),
                                );


                              }, icon: Icon(CupertinoIcons.bookmark_fill))
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      );

                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        onPressed: (){
          setState((){
            searchbyfl(searchController.text.toString());
          });
        },
        child: Icon(CupertinoIcons.search,color: Colors.white,),
      ),
    );
  }
}

















//This is the Json Model Class for the api
Searchmealbyletter searchmealbyletterFromJson(String str) => Searchmealbyletter.fromJson(json.decode(str));

String searchmealbyletterToJson(Searchmealbyletter data) => json.encode(data.toJson());

class Searchmealbyletter {
  List<Meal> meals;

  Searchmealbyletter({
    required this.meals,
  });

  factory Searchmealbyletter.fromJson(Map<String, dynamic> json) => Searchmealbyletter(
    meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}

class Meal {
  String? idMeal;
  String? strMeal;
  String? strDrinkAlternate;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  String? strTags;
  String? strYoutube;
  // Add more fields as necessary based on the JSON structure

  Meal({
    this.idMeal,
    this.strMeal,
    this.strDrinkAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    // Initialize other fields as necessary
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    idMeal: json["idMeal"],
    strMeal: json["strMeal"],
    strDrinkAlternate: json["strDrinkAlternate"],
    strCategory: json["strCategory"],
    strArea: json["strArea"],
    strInstructions: json["strInstructions"],
    strMealThumb: json["strMealThumb"],
    strTags: json["strTags"],
    strYoutube: json["strYoutube"],
    // Add other fields as necessary
  );

  Map<String, dynamic> toJson() => {
    "idMeal": idMeal,
    "strMeal": strMeal,
    "strDrinkAlternate": strDrinkAlternate,
    "strCategory": strCategory,
    "strArea": strArea,
    "strInstructions": strInstructions,
    "strMealThumb": strMealThumb,
    "strTags": strTags,
    "strYoutube": strYoutube,
    // Add other fields as necessary
  };
}



//This API IS RESONSIBLE FOR SEARCHING THE VALUE FIRST LETTER
Future<RxList<dynamic>> searchbyfl(var value) async{
  final response=await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=$value"));
  final save= jsonDecode(response.body);
  RxList<dynamic> storevalue=[].obs;
  if(response.statusCode==200){
    if(save["meals"]!=null){
      for(var value in save['meals']){
        storevalue.add(value);
      }
    }
    return storevalue;
  }
  else{
    throw Exception("Failed to search value");
  }
}
