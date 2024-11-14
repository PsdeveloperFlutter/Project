//This code is Responsible for the Search The Receipe with help of name when the user Enter the name of Receipe so it show to them .It is the MainPage of the Application .
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Meal Api/Search api by name .dart';
import 'package:get/get.dart';

import 'RecipeDetails.dart';
import 'Show Details page.dart';

class mainscreen extends StatefulWidget {
  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var islike1 = false;
  var islike2 = false;
  var tap1 = false;
  var tap2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //HomePage(),
          Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search Receipe by Name ",
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
                  contentPadding: const EdgeInsets.all(4.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future:
                      searchfunctionbyname(searchController.text.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("Error Occurred: ${snapshot.error}"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Recipe not found"));
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
                                const SizedBox(
                                  height: 12,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Food Name :- ",
                                      ),
                                      Text("${meal['strMeal']}",
                                          style: const TextStyle(
                                              fontFamily: 'Itim',
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Country Dish ',
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      TextSpan(
                                        text: meal["strArea"],
                                        style: const TextStyle(
                                            fontFamily: 'Itim',
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Text(
                                        "Receipe",
                                        style: TextStyle(
                                            fontFamily: 'Itim',
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${meal["strInstructions"]}",
                                        style: const TextStyle(
                                            fontFamily: 'Itim',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),

                                //This is the Button for More Details
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          //When the User Press on it so it Navigate to another Screen

                                          Navigator.push(context, MaterialPageRoute(builder: (_)=> Recipedetails(values:meal['strMeal'])));

                                        },
                                        child: const Text("More Details",style: TextStyle(fontFamily: 'Itim',),)),
                                    InkWell(
                                      onTap: () => _ontapicon1(),
                                      child: AnimatedScale(
                                          scale: tap1 ? 1.8 : 1.1,
                                          duration: const Duration(milliseconds: 300),
                                          child: Icon(
                                            CupertinoIcons.hand_thumbsup_fill,
                                            color: islike1
                                                ? Colors.blue
                                                : Colors.black,
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () => _ontapicon2(),
                                      child: AnimatedScale(
                                          scale: tap2 ? 1.8 : 1.1,
                                          duration: const Duration(milliseconds: 300),
                                          child: Icon(
                                            CupertinoIcons.bookmark_fill,
                                            color: islike2
                                                ? Colors.blue
                                                : Colors.black,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        onPressed: () {
          setState(() {
            searchfunctionbyname(searchController.text.trim().toString());
          });
        },
        child: const Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ),
      ),
    );
  }

//This Function is Responsible for the Icon change in the Ingredients section
  RxBool seticons = false.obs;
  bool seticon(RxBool value) {
    if (value.value) {
      value.value = false;
      return value.value;
    } else {
      value.value = true;
      return value.value;
    }
  }



  _ontapicon1() {
    setState(() {
      tap1 = true;
      islike1 = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          tap1 = false;
        });
      });
    });
  }

  _ontapicon2() {
    setState(() {
      tap2 = true;
      islike1 = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          tap2 = false;
        });
      });
    });
  }
}
