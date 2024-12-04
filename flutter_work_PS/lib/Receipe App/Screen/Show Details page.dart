import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class showdetailspage extends StatelessWidget {
  final Map<String, dynamic> values;
  showdetailspage(this.values);

  // Function to navigate to the InAppWebView screen
  void _openInAppWebView(BuildContext context, String url) {
    if (url.isNotEmpty) {
    } else {
      // Show a message if the URL is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("URL not available")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(values['strMeal'] ?? "Meal Details",style: TextStyle(color: Colors.white,fontSize: 12),),
      ),
      body: Card(
        elevation: 15,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(style: BorderStyle.solid),
          ),
          child: Card(
            elevation: 10,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Text("ID: ${values['idMeal'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Meal: ${values['strMeal'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Drink Alternate: ${values['strDrinkAlternate'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Category: ${values['strCategory'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Area: ${values['strArea'] ?? "Not available"}"),
                SizedBox(height: 5,),


                ExpansionTile(title:Text("Instructions")
                  ,trailing: Icon(CupertinoIcons.arrow_down)
                  ,children: [
                  Text("Instructions: ${values['strInstructions'] ?? "Not available"}", style: TextStyle(color: Colors.grey.shade700,fontFamily:'Itim' ),),
                ],),

                SizedBox(height: 4,),
                Container(
                  margin: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      values['strMealThumb'] ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return Text("Image not available");
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                Text("Tags: ${values['strTags'] ?? "Not available"}"),
                SizedBox(height: 4,),
                GestureDetector(
                  onTap: () {
                    final youtubeUrl = values['strYoutube'] ?? "";
                    if (youtubeUrl.isNotEmpty) {
                      _openInAppWebView(context, youtubeUrl);
                    }
                  },
                  child: Text(
                    "YouTube: ${values['strYoutube'] ?? "Not available"}",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 4,),
                Text("Ingredient 1: ${values['strIngredient1'] ?? "Not available"}"),
                // Additional Ingredients and Measurements...
                SizedBox(height: 4,),
                GestureDetector(
                  onTap: () {
                    final sourceUrl = values['strSource'] ?? "";
                    if (sourceUrl.isNotEmpty) {
                      _openInAppWebView(context, sourceUrl);
                    }
                  },
                  child: Text(
                    "Source: ${values['strSource'] ?? "Not available"}",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 4,),
                Text("Image Source: ${values['strImageSource'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Creative Commons Confirmed: ${values['strCreativeCommonsConfirmed'] ?? "Not available"}"),
                SizedBox(height: 4,),
                Text("Date Modified: ${values['dateModified'] ?? "Not available"}"),
                SizedBox(height: 4,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

