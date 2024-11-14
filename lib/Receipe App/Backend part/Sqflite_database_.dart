import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class dbhelper {
  dbhelper._();
  static final dbhelper getinstance = dbhelper._();

//Here I create the Database Object db
  Database? mydb;

//Know We check In Our Database We already create the Database or not

  Future<Database> getdb() async {
    return mydb == null ? await opendb() : mydb!;
  }

//This is the Function Which is Responsible for Open Our DB
  Future<Database> opendb() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String dbpath = join(appdir.path, "noteDB.db");
    return await openDatabase(dbpath, onCreate: (db, version) {
      db.execute(
          'create table recipedatabase(meal text,area text ,instruction text , images text)');
    },version: 1);
  }

//Add the Recipe in Database
  Future<bool> addrecipe(
      var meals, var areas, var instructions, var imagess) async {
    var db = await getdb();
    int roweffected = await db.insert('recipedatabase', {
      'meal': meals,
      'area': areas,
      'instruction': instructions,
      'images': imagess
    });
    return roweffected > 0;
  }

//get the Recipe from the Database
  Future<List<Map<String, dynamic>>> getrecipe() async {
    var db = await getdb();
    dynamic store = await db.query('recipedatabase');
    return store;
  }


  //This is the Function for The Deletion Process
Future<bool> dodelete(var meal)async{
var db=await getdb();
dynamic store=await db.delete('recipedatabase',where:"meal=?",whereArgs: [meal]);
return store>0;
}
}
