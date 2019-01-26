import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoz/model/todo.dart';

class DbHelper {
  String tblTodoz = "todoz";
  String colID = "id";
  String colPriority = "priority";
  String colDescription = "description";
  String colTitle = "title";
  String colDate = "date";
  static Database _db;
  //getter for DB , it's the one and only instance (starts with _ )
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDB();
    }
    return _db;
  }

  /* the singletone limits the number of objects created of a class to only one, this is helpful here becasue a DB helper is needed only once*/
  static final DbHelper _dbhelper = new DbHelper
      ._internal(); // create a private instance of the classs (starts with _ in the object name)
  //constructors
  DbHelper._internal(); // this is the interal private constructor used to initiate the single instance of the class
  factory DbHelper() {
    // this is the factory unnamed public constructor which returns THE single instance of the class
    return _dbhelper;
  }

  //methods
  Future<Database> initializeDB() async {
    Directory dir =
        await getApplicationDocumentsDirectory(); // get the director which is different in each os
    String path = dir.path + "todoz.db"; // get the path to the DB
    var dbTodoz = openDatabase(path,
        version: 1,
        onCreate:
            _createDB); //open the database if created, or call _createDB method
    return dbTodoz;
  }

  //create DB method, will create empty table for use in the app
  void _createDB(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblTodoz($colID INTEGER PRIMARY KEY, $colPriority INTEGER, $colTitle TEXT, $colDescription TEXT, $colDate TEXT)");
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db; // get the db
    var result = await db.insert(tblTodoz,
        todo.toMaps()); //  insert the record (await becasue it's async transaction)
    /*if it returns zero then there is a problem, need to implement a handling code here , the number is the id of the todo we are inserting in the db*/
    return result;
  }

  Future<List> getTodoz() async {
    Database db = await this.db; // get the db
    var result =
        await db.rawQuery("SELECT * FROM $tblTodoz ORDER BY $colPriority");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db; // get the db
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count(1) from $tblTodoz"));
    return result;
  }

  Future<int> updateTodoz(Todo todo) async {
    Database db = await this.db; // get the db
    var result = await db.update(tblTodoz, todo.toMaps(),
        where: "$colID = ?",
        whereArgs: [todo.id]); // update like insert takes table name and values
    return result;
  }

  Future<int> deleteTodoz(int id) async {
    Database db = await this.db;
    int result;
    result = await db.rawDelete("DELETE FROM $tblTodoz WHERE $colID = $id");
    return result;
  }
}
