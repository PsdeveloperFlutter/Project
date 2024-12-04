import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Meal Api/strCategory api.dart';
import 'Filter by Category UI.dart';
import 'UI component .dart';

class Strcategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Meal Categories",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            HomePage(),
            FutureBuilder(
              future: fetchstrcategory(),
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
                                trailing: Icon(
                                  CupertinoIcons.down_arrow,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "${index + 1} :- ${snapshot.data![index].strCategory}",
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
                                        child: filterbycategoryUI(
                                            snapshot.data![index].strCategory)),
                                  )
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
