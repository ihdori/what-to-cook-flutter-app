import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  String dbName = 'what_to_cook.db';

  // Private constructor
  DatabaseHelper._internal();

  // Factory constructor to return the same instance
  factory DatabaseHelper() {
    return _instance;
  }

  // Method to initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    // Check if the database already exists
    var exists = await databaseExists(path);

    if (!exists) {
      // If the database does not exist, copy it from the assets
      await Directory(dirname(path)).create(recursive: true);

      ByteData data = await rootBundle.load(join('assets', dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    return await openDatabase(path);
  }

  ddeleteDatabase() async {
    final String databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);
    await deleteDatabase(path);
  }

  // Method to fetch data from a specific table
  Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await database;
    return await db.query(tableName);
  }

  read(sql) async {
    List<Map> response = await _database!.rawQuery(sql);
    return response;
  }

  // You can add more CRUD methods here (insert, update, delete)
}

// Future<Database> getDatabase() async {
//   String databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, "your_database.db");

//   bool exists = await databaseExists(path);

//   if (!exists) {
//         await Directory(dirname(path)).create(recursive: true);

//     ByteData data = await rootBundle.load(join("assets", "your_database.db"));
//     List<int> bytes =
//         data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//     await File(path).writeAsBytes(bytes, flush: true);
//   }

//   return await openDatabase(
//     path,
//     version: 1,
//     onCreate: _create,
//     onUpgrade: _onUpgrade,
//   );
// }

// _create(Database db, int version) async {
//   // Create tables if needed
// }

// _onUpgrade(Database db, int oldVersion, int newVersion) async {
//   // Handle database upgrade
// }
