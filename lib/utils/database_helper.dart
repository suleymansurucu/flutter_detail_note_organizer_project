import 'dart:async';
import 'dart:io';

import 'package:detail_note_organizer_project/models/category.dart';
import 'package:detail_note_organizer_project/models/notes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper.internal();
  static Database? _database;

  factory DatabaseHelper() => _databaseHelper;

  DatabaseHelper.internal();

  Future<Database?> _getDatabase() async {
    _database ??= await _initializeDatabase();
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "appDB.db");


// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(url.join("assets", "notes_db.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

// open the database
    var _db = await openDatabase(path, readOnly: false);
    return _db;
  }

  Future<List<Map<String,dynamic>>> getCategory() async{
    var db= await _getDatabase();
    var resultCategory= await db!.query('category');
    return resultCategory;
  }

  Future<int?> addCategory(Category category)async{
    var db= await _getDatabase();
  var result=await db?.insert('category', category.toMap());
  return result;
  }

  Future<int?> updateCategory(Category category)async{
    var db= await _getDatabase();
    var result=await db?.update('category', category.toMap(), where: 'categoryID = ?', whereArgs: [category.categoryID]);
    return result;
  }
  Future<int?> deleteCategory(int categoryID)async{
    var db= await _getDatabase();
    var result=await db?.delete('category', where: 'categoryID = ?', whereArgs: [categoryID]);
    return result;
  }


  Future<List<Map<String,dynamic>>> getNotes() async{
    var db= await _getDatabase();
    var resultNotes= await db!.query('notes', orderBy: 'NoteId DESC');
    return resultNotes;
  }

  Future<int?> addNote(Notes notes)async{
    var db= await _getDatabase();
    var result=await db?.insert('notes', notes.toMap());
    return result;
  }

  Future<int?> updateNote(Notes notes)async{
    var db= await _getDatabase();
    var result=await db?.update('notes', notes.toMap(), where: 'noteID = ?', whereArgs: [notes.noteID]);
    return result;
  }
  Future<int?> deleteNote(int noteID)async{
    var db= await _getDatabase();
    var result=await db?.delete('notes', where: 'noteID = ?', whereArgs: [noteID]);
    return result;
  }
}
