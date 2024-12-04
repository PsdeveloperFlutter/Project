

import '../Backend part/Sqflite_database_.dart';
import 'RecipeDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Meal Api/FilterbyCategoryAPI.dart';
import '../Meal Api/Search api by name .dart';
import 'UI component .dart';

final isBookmarked = false.obs;

class filterbycategoryUI extends StatelessWidget {
  final values;
  filterbycategoryUI(this.values);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchingcategories(values),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Recipe not found ",
                style: TextStyle(fontFamily: 'Itim'),
              ),
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
                                      builder: (_) => Recipedetails(
                                          values:
                                              snapshot.data![index].strMeal)));
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "Recipe :-  ${snapshot.data![index].strMeal}",
                                      style: TextStyle(fontFamily: 'Itim')),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(CupertinoIcons.hand_point_left,color:index%2==0?Colors.blue:Colors.green.shade700,size: 30,),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Recipe Id :- ${snapshot.data![index].idMeal}",
                                style: TextStyle(fontFamily: 'Itim')),
                            IconButton(
                              onPressed: () {
                                dbhelper object =dbhelper.getinstance;
                                object.addrecipe(snapshot.data![index].strMeal, "Area", "Instruction", snapshot.data![index].strMealThumb.toString());
                                isBookmarked.value = !isBookmarked
                                    .value; // Toggle bookmark state
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
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          }
        });
  }
}
