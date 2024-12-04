import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RecipeDetails.dart';
import 'UI component .dart';
import '../Meal Api/Search API BY ID .dart';

class idwisesearch extends StatefulWidget {
  @override
  State<idwisesearch> createState() => _IdWiseSearchState();
}

class _IdWiseSearchState extends State<idwisesearch> {
  TextEditingController searchController = TextEditingController();
  late Future<RxList<dynamic>> _searchResult;

  @override
  void initState() {
    super.initState();
    _searchResult = searchbyID(52772); // Default recipe ID for initial load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomePage(),
          Column(
            children: [
              SizedBox(height: 50,),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Search Receipe by ID ",
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(fontSize: 12, color: Colors.black),
                  contentPadding: EdgeInsets.all(4.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Expanded(
                child: FutureBuilder(
                  future: _searchResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                width: 180,
                                height: 180,
                                child: Image.asset("assets/images/notfound.png")),
                          ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Image.asset("assets/images/notfound.png"));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var meal = snapshot.data![index];
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
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text("${meal["strMeal"]}"),
                                ElevatedButton(
                                  onPressed: () {
                                    //When the User Press on it so it Navigate to another Screen

                                    Navigator.push(context, MaterialPageRoute(builder: (_)=> Recipedetails(values:meal['strMeal'])));

                                  },
                                  child: Text("More Details"),
                                ),
                                SizedBox(height: 20),
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


        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        onPressed: () {
          setState(() {
            dynamic store = int.tryParse(searchController.text) ?? 52772;
            _searchResult = searchbyID(store);
          });
        },
        child: Icon(CupertinoIcons.search, color: Colors.white),
      ),
    );
  }
}
