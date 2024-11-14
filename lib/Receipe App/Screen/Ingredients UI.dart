import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RecipeDetails.dart';
import '../Meal Api/Fliter by Area.dart';
import '../Meal Api/Ingredients fetching API .dart';
import '../Meal Api/SearchwayIngredients  API .dart';
import 'Filter by Category UI.dart';
import 'UI component .dart';

class strIngredients extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Ingredients Categories",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
      body: Stack(
        children: [
          HomePage(),
          Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: fetchingingredients(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data found'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Divider(
                                thickness: 0,
                                color: Color(0),
                              ),
                              Card(
                                elevation: 5,
                                child: ExpansionTile(
                                  trailing: Icon(
                                    CupertinoIcons.down_arrow,
                                    color: Colors.blue.shade700,
                                  ),
                                  title: Text(
                                    "${snapshot.data![index].idIngredient ?? "Not Available"} :-${snapshot.data![index].strIngredient ?? "Not Available"}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Itim',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  children: [
                                    // This is UI part of Search Ingredient UI
                                    SingleChildScrollView(
                                      child: Container(
                                          width: 400,
                                          height: 500,
                                          child: searchbyIngredientUI(snapshot
                                              .data![index].strIngredient)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// This is Responsible for the Fetching the Meal According to the user selection and the base of list Which I create of Ingredients

class searchbyIngredientUI extends StatelessWidget {
  final values;
  final isBookmarked = false.obs;
  searchbyIngredientUI(this.values);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchIngredients(values),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Recipe not found "),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: 230,
                            height: 230,
                            child: Image.network(
                                snapshot.data![index].strMealThumb ??
                                    "Not Available"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recipedetails(
                                        values: snapshot.data![index].strMeal,
                                      )));
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "Recipe :-  ${snapshot.data![index].strMeal ?? "Not Available"}",
                                style: TextStyle(fontFamily: 'Itim'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(CupertinoIcons.hand_point_left,color:index%2==0?Colors.blue:Colors.green.shade700,size: 30,),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Recipe Id :- ${snapshot.data![index].idMeal ?? "Not Available"}",
                            style: TextStyle(fontFamily: 'Itim'),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          IconButton(
                            onPressed: () {
                              // Define your action here
                              dbobject
                                  .addrecipe(
                                  snapshot.data![index].strMeal,
                                  "Area",
                                  "Instructions",
                                  snapshot.data![index].strMealThumb.toString())
                                  .then((_) =>
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor:
                                    Colors.blue.shade700,
                                    content: Text(
                                        "Recipe has saved "), // Customize the message
                                    duration: Duration(seconds: 1),
                                  )));
                              isBookmarked.value =
                                  !isBookmarked.value; // Toggle bookmark state
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text("Recipe has Saved"),
                                  backgroundColor: Colors.blue.shade700,
                                ),
                              );
                            },
                            icon: Obx(
                              () => AnimatedScale(
                                scale: isBookmarked.value
                                    ? 1.3
                                    : 1.0, // Animate icon on press
                                duration: Duration(milliseconds: 300),
                                child: Icon(
                                  CupertinoIcons.bookmark_fill,
                                  color: isBookmarked.value
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
