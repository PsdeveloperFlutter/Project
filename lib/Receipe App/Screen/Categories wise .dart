//This Code is Responsible for the Categories wise page show in the code

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model class for parsing the API response
class CategoryResponse {
  List<Category> categories;

  CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(String str) =>
      CategoryResponse.fromMap(json.decode(str));

  factory CategoryResponse.fromMap(Map<String, dynamic> json) =>
      CategoryResponse(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
      );
}

class Category {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );
}

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = fetchCategories();
  }

  // Function to fetch data from the API
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    if (response.statusCode == 200) {
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(response.body);
      return categoryResponse.categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(fontFamily: 'Itim'),));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          color: Color(0xFFF3FF6D),
                          child: InkWell(
                              onTap: () =>
                                  seeimage(category.strCategoryThumb, context),
                              child: Image.network(category.strCategoryThumb)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("* ${category.strCategory}",style: TextStyle(fontSize: 18,fontFamily: 'Itim',fontWeight: FontWeight.bold,),),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(category.strCategoryDescription,style: TextStyle(fontSize: 14,fontFamily: 'Itim'),),
                    ),
                    SizedBox(
                      height: 18,
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }


  //This is function is Responsible for the Showing the image in the dialog box when the user press at image
  seeimage(strCategoryThumb, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Image.network(strCategoryThumb),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Exit",style: TextStyle(fontFamily: 'Itim'),))
            ],
          );
        });
  }
}
