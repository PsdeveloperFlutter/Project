//This is the code of the UI of the Country wise Show the Receipe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Meal Api/Search by COUNTRY.dart';
import 'Filter by Category UI.dart';
import 'RecipeDetails.dart';

class countrywisesearch extends StatefulWidget {
  @override
  State<countrywisesearch> createState() => _countrywisesearchState();
}

class _countrywisesearchState extends State<countrywisesearch> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Receipe by Name ",
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
          Expanded(
            child: FutureBuilder(
              future: searchbycountry(searchController.text.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Error Occurred: ${snapshot.error}",style: TextStyle(fontFamily: 'Itim')));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Recipe not found",style: TextStyle(fontFamily: 'Itim')));
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
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text("${meal["strMeal"]}",style: TextStyle(fontFamily: 'Itim')),
                            SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Recipedetails(
                                                  values: meal["strMeal"])));
                                    },
                                    child: Text("More Details",style: TextStyle(fontFamily: 'Itim'),)),
                                IconButton(
                                    onPressed: () {

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


                                    },
                                    icon: Icon(CupertinoIcons.bookmark_fill))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
        onPressed: () {
          setState(() {
            searchbycountry(searchController.text.trim().toString());
          });
        },
        child: Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
