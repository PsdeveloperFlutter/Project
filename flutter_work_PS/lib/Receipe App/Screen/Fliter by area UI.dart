//This UI for the Ingredients Related to user Search
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Meal Api/AreaSearching API.dart';
import 'RecipeDetails.dart';

import '../Meal Api/Fliter by Area.dart';
import 'Filter by Category UI.dart';
import 'UI component .dart';

class strarea extends StatelessWidget {
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
              "Countries Categories",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        body: Stack(
          children: [
            HomePage(),
            FutureBuilder(
              future: filterbyarea(),
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
                          const Divider(
                            thickness: 0,
                            color: Color(0),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: ExpansionTile(
                                trailing: const Icon(
                                  CupertinoIcons.down_arrow,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "${index + 1} :- ${snapshot.data![index].strArea}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  //This is the Function is Responsible for Categrories Item When the user click on the list and so Meal Categories is appear and related dish.
                                  SingleChildScrollView(
                                      child: Container(
                                          width: 400,
                                          height: 500,
                                          child: searchbyareaUI(
                                              snapshot.data![index].strArea))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ));
  }
}

//This is Responsible for the Fetching the Meal According to the user selection and the base of list Which I create

class searchbyareaUI extends StatelessWidget {
  final values;
  searchbyareaUI(this.values);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchbyarea(values),
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
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Card(
                            elevation: 5,
                            child: Container(
                                child: Image.network(
                                    snapshot.data![index].strMealThumb)),
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
                                            values:
                                                snapshot.data![index].strMeal,
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
                                  Icon(
                                    CupertinoIcons.hand_point_left,
                                    color: index % 2 == 0
                                        ? Colors.blue
                                        : Colors.green.shade700,
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Recipe Id :- ${snapshot.data![index].idMeal}",
                              style: TextStyle(fontFamily: 'Itim'),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            IconButton(
                                onPressed: () {
                                  // Define your action here
                                  dbobject.addrecipe(
                                      snapshot.data![index].strMeal,
                                      "Area",
                                      "Instructions",
                                      snapshot.data![index].strMealThumb
                                          .toString());

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text("Recipe has Saved"),
                                    backgroundColor: Colors.blue.shade700,
                                  ));
                                },
                                icon: Icon(CupertinoIcons.bookmark_fill))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        });
  }
}
