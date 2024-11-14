import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Meal Api/Search API BY ID .dart';
import '../Meal Api/Search api by name .dart';
import 'Categories wise .dart';
import 'package:flutter/cupertino.dart';
import 'CountrywiseSEARCH.dart';
import 'Fliter by area UI.dart';
import 'Ingredients UI.dart';
import 'Mainpage.dart';
import 'SAVE LIST OF RECIPE .dart';
import 'Search by ID UI .dart';
import 'Search by firstletter.dart';
import 'StrcategoryUI.dart';

class HomePages extends StatefulWidget {
  @override
  State<HomePages> createState() => _HomePageState();
}

class _HomePageState extends State<HomePages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    searchfunctionbyname("rice");
    searchbyfl('a');
    searchbyID(int.parse("52772"));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: InkWell(
          onTap: () {
            Get.to(Strcategory());
          },
          child: const Text("Recipe App",
              style: TextStyle(fontSize: 15, color: Colors.white)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: PopupMenuButton<String>(
              color: Colors.blue,
              icon: Icon(CupertinoIcons.ellipsis, color: Colors.white),
              onSelected: (value) {
                // Handle menu selections here
                if (value == 'Search by ID') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => idwisesearch()));
                } else if (value == 'Category') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Strcategory()));
                } else if (value == 'Ingredients') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => strIngredients()));
                } else if (value == 'Area-Wise') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => strarea()));
                } else if (value == "Save-Recipe") {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => saveRecipe()));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Search by ID',
                  child: Text('Search by ID', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'Category',
                  child: Text('Category', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'Ingredients',
                  child: Text('Ingredients', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'Area-Wise',
                  child: Text('Area-Wise', style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem<String>(
                  value: 'Save-Recipe',
                  child: Text('Saved Recipe', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),

        ],
        bottom: TabBar(

          indicatorColor: Colors.white,
          labelStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),
          unselectedLabelStyle: TextStyle(fontSize: 10, color: Colors.white),
          controller: _tabController,
          tabs: const [
            Tab(child: Text("Home", textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Itim'),)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Tab(child: Text("Category", textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Itim'))),
            ),
            Tab(child: Text("Search", textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Itim'))),
            Tab(child: Text("Country", textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Itim'))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          mainscreen(),
          CategoryScreen(),
          searchbyfirstletter(),
          countrywisesearch(),
        ],
      ),
    );
  }
}
