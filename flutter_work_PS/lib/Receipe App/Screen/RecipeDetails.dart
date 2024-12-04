import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Backend part/Sqflite_database_.dart';
import '../Meal Api/Search api by name .dart';

dynamic instruction;
dbhelper dbobject = dbhelper.getinstance;

class Recipedetails extends StatefulWidget {
  final values;
  Recipedetails({
    required this.values,
  });

  @override
  State<Recipedetails> createState() => _RecipedetailsState();
}

class _RecipedetailsState extends State<Recipedetails> {
  var meal;
  bool isLiked = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Ensure meal is initialized only when snapshot data is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && meal != null && meal["strYoutube"] != null) {
        _controller = VideoPlayerController.networkUrl(meal["strYoutube"])
          ..initialize().then((_) {
            setState(() {}); // Update the UI when the video is initialized
          });
      }
    });
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Details",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: searchfunctionbyname(widget.values),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Recipe is not found "),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                meal = snapshot.data![index];
                // Reinitialize the video controller if needed
                if (meal["strYoutube"] != null) {
                  _controller = VideoPlayerController.networkUrl(Uri.parse(meal["strYoutube"]))
                    ..initialize().then((_) {
                      setState(() {}); // Update the UI when the video is initialized
                    });
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Card(
                    elevation: 15,
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          meal["strMealThumb"] != null
                              ? Card(
                            elevation: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                width: 300,
                                height: 270,
                                child: Image.network(
                                  meal["strMealThumb"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                              : Text("Image is not found"),
                          SizedBox(height: 10),
                          Text(
                            "Meal Name: ${meal["strMeal"]}",
                            style: TextStyle(fontFamily: 'Itim'),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Category: ${meal["strCategory"]}",
                            style: TextStyle(fontFamily: 'Itim'),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Area: ${meal["strArea"]}",
                            style: TextStyle(fontFamily: 'Itim'),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Instructions: ${meal["strInstructions"]}",
                            style: TextStyle(fontFamily: 'Itim'),
                          ),
                          SizedBox(height: 5),
                          ExpansionTile(
                            title: Text("Video of Recipe"),
                            children: [
                              Center(
                                child: _controller.value.isInitialized
                                    ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                                    : CircularProgressIndicator(),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  dbobject.addrecipe(
                                    meal["strMeal"],
                                    meal["strArea"],
                                    meal['strInstructions'],
                                    meal["strMealThumb"].toString(),
                                  ).then((_) =>
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        backgroundColor: Colors.blue.shade700,
                                        content: Text("Recipe has saved "),
                                        duration: Duration(seconds: 1),
                                      )));
                                },
                                icon: Icon(
                                  CupertinoIcons.bookmark_fill,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "ID: ${meal["idMeal"]}",
                                style: TextStyle(fontFamily: 'Itim'),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No recipe data available"),
            );
          }
        },
      ),
    );
  }
}
