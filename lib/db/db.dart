import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/models/quote.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "quotes";

  static Future<void> initDB() async {
    print("inside the function!!!!!!!");
    if (_db != null) {
      print("Already Exist");
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'tasks.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) async {
            print("Create Quotes Table");
            await db.execute("CREATE TABLE ${_tableName}("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "text STRING, author STRING,"
                "isFavourite INTEGER)");
          },
        );
        print("Created the table");
      } catch (err) {
        print("There is an Error here");
        print(err);
      }
    }
  }

  static Future<int> insert(Quote quote) async {
    return await _db?.insert(_tableName, quote.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<List<Map<String, dynamic>>> getFavourites() async {
    return await _db!.query(_tableName, where: "isFavourite=?", whereArgs: [1]);
  }

  static Future<void> delete(Quote quote) async {
    int index =
        await _db!.delete(_tableName, where: "id=?", whereArgs: [quote.id]);
  }

  static Future<bool> checkExist(Quote quote) async {
    List<Map<String, dynamic>> list =
        await _db!.query(_tableName, where: 'text=?', whereArgs: [quote.text]);

    bool find = list.isEmpty ? false : true;
    return find;
  }

  static Future<void> deleteAllQuotes() async {
    await _db!.delete(_tableName);
    print("Deleted all quotes from $_tableName table.");
  }
}
