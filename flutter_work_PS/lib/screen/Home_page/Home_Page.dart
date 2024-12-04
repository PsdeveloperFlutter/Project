//This is page for the homepage ui of the Instagram Flutter
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../Profile_directory/Profile.dart';
import '../following/followingscreen.dart';
import '../messagescreen.dart';

var arrContent = [
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"},
  {
    "img":
        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
  },
  {
    "img": "https://cdn.pixabay.com/photo/2024/05/26/10/15/bird-8788491_640.jpg"
  },
  {"img": "https://pixlr.com/images/generator/how-to-generate.webp"}
];

class BottomNavScreen extends StatefulWidget {
  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentindex = 0;

  List<Widget> pages = [
    Homescreen(),
    SearchScreen(),
    postscreen(),
    Heartscreen(),
    Profilescreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        //This is FOR THE SETSTATE CHANGE
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.plus_app), label: "Post"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "HeartScreen"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
        ],
      ),
      body: IndexedStack(
        children: pages,
        index: currentindex,
      ),
    );
  }
}

//It is for HomeScreen
class Homescreen extends StatelessWidget {
  var arrContent = [
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "Your Story"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "karennne"
    },
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "zackjohn"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "kieron_d"
    },
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "Your Story"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "karennne"
    },
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "zackjohn"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "kieron_d"
    },
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "Your Story"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "karennne"
    },
    {
      "img":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2dVbLMzlaeJnL5C6RpZ8HLRECJhH6ILEGKg&s",
      "name": "zackjohn"
    },
    {
      "img":
          "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
      "name": "kieron_d"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        backgroundColor: Colors.black12,
        leading: uihelper.setimage2("Camera Icon.png"),
        title: Image.asset("assets/images/logo.png"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: uihelper.setimage2('IGTV.png')),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => messagescreen()));
              },
              icon: uihelper.setimage2("Messanger.png"))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(arrContent[index]["img"].toString()),
                    ),
                  );
                },
                itemCount: arrContent.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      arrContent[index]["name"]!,
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                },
                itemCount: arrContent.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 54,
              width: double.infinity,
              color: Colors.black12,
              child: ListTile(
                leading: uihelper.setimage2("person1.png"),
                title: Text(
                  "joshua_I",
                  style: TextStyle(fontSize: 13, color: Color(0XFFF9F9F9)),
                ),
                subtitle: Text(
                  "Tokyo, Japan",
                  style: TextStyle(fontSize: 11, color: Color(0XFFF9F9F9)),
                ),
                trailing: uihelper.setimage2("More Icon.png"),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            child: Container(
                clipBehavior: Clip.antiAlias,
                height: 213,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Image.asset(
                  "assets/images/Rectangle (1).png",
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              uihelper.setimage2("Like.png"),
              SizedBox(
                width: 20,
              ),
              uihelper.setimage2("Comment.png"),
              SizedBox(
                width: 20,
              ),
              uihelper.setimage2("Messanger.png"),
              SizedBox(
                width: 20,
              ),
              uihelper.setimage2("Save.png")
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                uihelper.setimage2("Ovalone.png"),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Liked by craig_love and 44,686 others",
                  style: TextStyle(fontSize: 13, color: Color(0XFFF9F9F9)),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "joshua_l",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFFF9F9F9)),
                ),
                Text(
                  " The game in Japan was amazing and I want",
                  style: TextStyle(fontSize: 13, color: Color(0XFFF9F9F9)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



class  postscreen extends StatelessWidget {
  var arrContent = [
    {
      "img":
      "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg"
    },
    {
      "img":
      "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg"
    },
    {
      "img":
      "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455_640.jpg"
    },
    {
      "img":
      "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg"
    },
    {
      "img":
      "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg"
    },
    {
      "img":
      "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455_640.jpg"
    },
    {
      "img":
      "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?cs=srgb&dl=pexels-anjana-c-169994-674010.jpg&fm=jpg"
    },
    {
      "img":
      "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg"
    },
    {
      "img":
      "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455_640.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.antiAlias,
              height: 124,
              width: 124,
              decoration: BoxDecoration(),
              child: Image.network(arrContent[index]["img"].toString(),fit: BoxFit.cover,),
            );
          },
          itemCount: arrContent.length,
        ));
  }
}

//This is related to the search Screen of the app
class SearchScreen extends StatefulWidget {
  TextEditingController searchcontroller = TextEditingController();
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  //It is Main Which is Change Every time When user press on the selection option
  final RxList<dynamic> arrContent = [].obs;

  //It is for the Cars
  final RxList<dynamic> cars = [
    {"img": "assets/images/car1.jpeg"},
    {"img": "assets/images/car2.jpeg"},
    {"img": "assets/images/car3.jpeg"},
    {"img": "assets/images/car4.webp"},
    {"img": "assets/images/car5.webp"},
    {"img": "assets/images/car6.webp"},
    {"img": "assets/images/car7.webp"},
    {"img": "assets/images/car8.webp"},
    {"img": "assets/images/car9.jpeg"},
    {"img": "assets/images/car10.jpeg"},
  ].obs;

  //It is for the sports
  final RxList<dynamic> sports = [
    {"img": "assets/images/basketball-dunk-blue-game-163452.webp"},
    {"img": "assets/images/the-ball-stadion-football-the-pitch-46798.jpeg"},
    {"img": "assets/images/pexels-photo-209977.jpeg"},
    {"img": "assets/images/pexels-photo-248547.jpeg"},
    {"img": "assets/images/pexels-photo-269948.jpeg"},
    {"img": "assets/images/pexels-photo-358042.webp"},
    {"img": "assets/images/pexels-photo-841130.jpeg"},
    {"img": "assets/images/pexels-photo-841130.jpeg"},
    {"img": "assets/images/pexels-photo-863988.jpeg"},
    {"img": "assets/images/pexels-photo-1415810.jpeg"},
    {"img": "assets/images/pexels-photo-1618269.jpeg"},
    {"img": "assets/images/pexels-photo-8336927.jpeg"},
    {"img": "assets/images/pexels-photo-13461021.webp"},
    {"img": "assets/images/pexels-photo-14678657.webp"},
    {"img": "assets/images/pexels-photo-27928190.webp"},
    {"img": "assets/images/pexels-photo-27967561.webp"},
    {"img": "assets/images/pexels-photo-29062946.webp"}
  ].obs;

  //It is for the Showing the Images to UI
  final RxList<dynamic> random = [
    {"img": "assets/images/free-photo-of-a-woman-in-a-park.jpeg"},
    {
      "img":
          "assets/images/free-photo-of-artistic-still-life-with-heart-shaped-paddle.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-charming-front-door-with-sleeping-cat-and-plants.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-dynamic-long-exposure-of-los-angeles-traffic-at-night.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-flowers-and-plants-around-house-wall.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-intricate-white-spiral-staircase-in-lush-greenhouse.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-scenic-forest-path-in-fall-seattle-wa.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-steep-matterhorn-mountain-in-the-swiss-alps.jpeg"
    },
    {"img": "assets/images/free-photo-of-a-bird-flying-over-the-water.jpeg"},
    {"img": "assets/images/free-photo-of-a-woman-in-a-park.jpeg"},
    {
      "img":
          "assets/images/free-photo-of-aerial-view-of-coastal-wind-turbine-farm.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-artistic-still-life-with-heart-shaped-paddle.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-charming-front-door-with-sleeping-cat-and-plants.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-charming-sign-pointing-to-happiness-in-ibiza.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-colorful-lifeguard-tower-on-miami-beach.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-dynamic-long-exposure-of-los-angeles-traffic-at-night.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-flowers-and-plants-around-house-wall.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-intricate-white-spiral-staircase-in-lush-greenhouse.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-scenic-forest-path-in-fall-seattle-wa.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-seagulls-over-modern-bridge-and-cityscape.jpeg"
    },
    {
      "img":
          "assets/images/free-photo-of-seagulls-over-modern-bridge-and-cityscape (1).jpeg"
    },
  ].obs;

  oncars() {
    setState(() {
      arrContent.removeRange(0, arrContent.length);
      arrContent.addAll(cars);
    });
  }

  onrandom() {
    setState(() {
      arrContent.removeRange(0, arrContent.length);
      arrContent.addAll(random);
    });
  }

  onsports() {
    RxList<dynamic> store = [].obs;
    setState(() {
      arrContent.removeRange(0, arrContent.length);
      arrContent.addAll(sports);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  height: 36,
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFF262626),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(CupertinoIcons.search),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0XFF8E8E93),
                        fontWeight: FontWeight.normal,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset("assets/images/Live.png"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 32,
                  width: 75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: InkWell(
                    onTap: () => onrandom(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/Icon (2).png"),
                        const SizedBox(width: 8),
                        const Text(
                          "IGTV",
                          style:
                              TextStyle(fontSize: 14, color: Color(0XFFF9F9F9)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 32,
                  width: 75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.bag,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Shop",
                          style:
                              TextStyle(fontSize: 14, color: Color(0XFFF9F9F9)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 32,
                  width: 75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Style",
                        style:
                            TextStyle(fontSize: 14, color: Color(0XFFF9F9F9)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => onsports(),
                  child: Container(
                    height: 32,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sports",
                          style:
                              TextStyle(fontSize: 14, color: Color(0XFFF9F9F9)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 32,
                  width: 53,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: InkWell(
                    onTap: () => oncars(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Auto",
                          style:
                              TextStyle(fontSize: 14, color: Color(0XFFF9F9F9)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: arrContent.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => showImage(
                          arrContent[index]["img"].toString(), context),
                      child: Container(
                        margin: EdgeInsets.all(4),
                        clipBehavior: Clip.antiAlias,
                        height: 134,
                        width: 144,
                        decoration: const BoxDecoration(),
                        child: Image.asset(
                          arrContent[index]["img"].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  showImage(String imgPath, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  imgPath,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'Image Preview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'This is a sample image shown in a dialog box.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//This class responsible for the customization of the widget for the various UI purpose
class uihelper {
  static setimage(String imagevalue) {
    return Image.network("$imagevalue");
  }

  static setimage2(String value) {
    return Image.asset("assets/images/$value");
  }

  //This code is for the custom button ui in the flutter in the project of the instagram
  static customtextbutton(
      {required String value, required VoidCallback callback}) {
    return TextButton(
        onPressed: () {
          callback();
        },
        child: Text(
          "$value",
          style: const TextStyle(color: Color(0XFF3797EF), fontSize: 12),
        ));
  }

  static custombutton(
      {required VoidCallback callback, required String buttonname}) {
    return SizedBox(
      height: 45,
      width: 343,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF3797EF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          "$buttonname",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  //This class is the CustomTextField
  static customtextfield(
      {required TextEditingController controller,
      required String text,
      required bool tohide}) {
    return Container(
      height: 50,
      width: 343,
      decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade700)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextField(
          controller: controller,
          obscureText: tohide,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(fontSize: 14, color: Colors.white70),
              border: InputBorder.none),
        ),
      ),
    );
  }
}



