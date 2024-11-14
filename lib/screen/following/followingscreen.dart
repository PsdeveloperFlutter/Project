import'package:flutter/material.dart';

import '../../main.dart';

class Heartscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child:
    Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab
          ,
          tabs: [
            Tab(
              text: "Following",
            ),
            Tab(
              text: "You",
            )
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Followingscreen(),
          YouScreen()
        ],
      ),
    ));
  }
}



class Followingscreen extends StatelessWidget {


  var arrContent = [
    {
      "img": "Oval (2).png",
      "txt": "karennne liked 3 posts. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (3).png",
      "txt": "kiero_d, zackjohn and craig_love liked joshua_l photo. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (4).png",
      "txt": "kiero_d started following craig_love. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (5).png",
      "txt": "craig_love liked 8 posts. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (2).png",
      "txt": "karennne liked 3 posts. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (3).png",
      "txt": "karennne liked 3 posts. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (4).png",
      "txt": "karennne liked 3 posts. 3h",
      "lastimg": "Rectangle.png"
    },
    {
      "img": "Oval (5).png",
      "txt": "karennne liked 3 posts. 3h",
      "lastimg": "Rectangle.png"
    }
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(itemBuilder: (context,index){
          return Padding(padding: const EdgeInsets.only(top: 20),
          child: ListTile(
            leading: uihelper.setimage2(arrContent[index]["img"].toString()),
            title: Text(arrContent[index]["img"].toString()),
            trailing: uihelper.setimage2(arrContent[index]["img"].toString()),
          ),
          );

        },itemCount: arrContent.length,),
      ) ,
    );
  }
}


class YouScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:15,left:20),
                child: Text(
                  "Follow Requests",
                  style: TextStyle(fontSize: 15,color: Color(0XFFF9F9F9)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
            ,Container(
              height: 106,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("New",style: TextStyle(fontSize: 15),),
                    ],
                  )
                  ,
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SingleChildScrollView(
                      child: ListTile(
                        leading: uihelper.setimage2("Oval (4).png"),
                        title: Text(
                          "karennne liked your photo. 1h",
                          style: TextStyle(fontSize: 13),
                        ),
                        trailing: uihelper.setimage2("Rectangle.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Today",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ListTile(
                leading: uihelper.setimage2("Profiles.png"),
                title: Text(
                  "karennne liked your photo. 1h",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: uihelper.setimage2("Rectangle.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "This Week",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ListTile(
                leading: uihelper.setimage2("Oval (5).png"),
                title: Text(
                  "craig_love mentioned you in a comment: @jacob_w exactly..",
                  style: TextStyle(fontSize: 13),
                ),
                trailing: uihelper.setimage2("Rectangle.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ListTile(
                  leading: uihelper.setimage2("Oval (6).png"),
                  title: Text(
                    "martini_rond started following you. 3d",
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing: Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white54,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: Center(
                      child: Text("Message"),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: ListTile(
              leading: uihelper.setimage2("Oval (7).png"),
              title: Text(
                "maxjacobson started following you. 3d",
                style: TextStyle(fontSize: 13),
              ),
              trailing: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(3)),
                child: Center(
                  child: Text("Message"),
                ),
              )),
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "This Months",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: ListTile(
            leading: uihelper.setimage2("Oval (5).png"),
            title: Text(
              "craig_love mentioned you in a comment: @jacob_w exactly..",
              style: TextStyle(fontSize: 13),
            ),
            trailing: uihelper.setimage2("Rectangle.png"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: ListTile(
              leading: uihelper.setimage2("Oval (6).png"),
              title: Text(
                "martini_rond started following you. 3d",
                style: TextStyle(fontSize: 13),
              ),
              trailing: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(3)),
                child: Center(
                  child: Text("Message"),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: ListTile(
              leading: uihelper.setimage2("Oval (7).png"),
              title: Text(
                "maxjacobson started following you. 3d",
                style: TextStyle(fontSize: 13),
              ),
              trailing: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(3)),
                child: Center(
                  child: Text("Message"),
                ),
              )),
        )
          ],
        ),
      ),
    );
  }
}

