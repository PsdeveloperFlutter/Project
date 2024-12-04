import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Backend part/Sqflite_database_.dart';

class saveRecipe extends StatefulWidget {
  @override
  State<saveRecipe> createState() => _saveRecipeState();
}

class _saveRecipeState extends State<saveRecipe> {
  // This is the code which comes from the Database and shows in the UI

  dbhelper dbobject = dbhelper.getinstance;
  RxList<dynamic> allnotess = [].obs;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    allnotess.value = await dbobject!.getrecipe();
    setState(() {}); // Refresh the UI after fetching data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Saved Recipe'S",
          style: TextStyle(color: Colors.white, fontFamily: 'Itim'),
        ),
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
      ),
      body: // ListView.builder to show the fetched notes
          Expanded(
        child: allnotess.isEmpty
            ? Center(child: Text("No Recipe Available"))
            : Obx(
                () => ListView.builder(
                  itemCount: allnotess.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Center(
                                child: Container(
                                  child: Image.network(
                                    allnotess[index]['images'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Meal Name  ${index + 1}: ${allnotess[index]['meal']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Area: ${allnotess[index]['area']}',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ExpansionTile(
                              title: Text(
                                "Instruction'S",
                                style: TextStyle(fontFamily: 'Itim'),
                              ),
                              trailing: Icon(CupertinoIcons.arrow_down),
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Card(
                                    elevation: 4,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${allnotess[index]['instruction']}",
                                            style:
                                                TextStyle(fontFamily: 'Itim'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    // First, refresh the list from the database

                                    // Then, remove all the items from the database and UI
                                    for (int i = 0; i <=index; i++) {
                                      // Clear the list
                                      if (index == i) {
                                        dbobject.dodelete(allnotess[i][
                                            'meal']); // Delete from the database
                                        allnotess.remove(allnotess[i]);
                                      }
                                    }
                                    getNotes(); // Refresh the list to ensure UI is updated
                                  });
                                },
                                icon: Icon(CupertinoIcons.delete))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          setState(() {
            // First, refresh the list from the database

            // Then, remove all the items from the database and UI
            for (int i = 0; i < allnotess.length; i++) {
              dbobject
                  .dodelete(allnotess[i]['meal']); // Delete from the database
              allnotess.remove(allnotess[i]); // Clear the list
            }
            getNotes(); // Refresh the list to ensure UI is updated
          });
        },
        child: Icon(
          CupertinoIcons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
