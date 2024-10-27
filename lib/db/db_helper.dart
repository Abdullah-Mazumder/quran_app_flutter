import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db != null) return _db;

    String databasePath = (await initDatabase()).toString();
    _db = await openDatabase(databasePath, version: 1);
    return _db;
  }

  static Future<String> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // Create a 'data' directory inside the document directory
    String dataDirectoryPath = join(documentDirectory.path, 'data');
    Directory dataDirectory = Directory(dataDirectoryPath);
    if (!await dataDirectory.exists()) {
      await dataDirectory.create();
    }

    // Specify the path for the database inside the 'data' directory
    String databasePath = join(dataDirectoryPath, 'data.db');

    // Check if the database file exists
    if (await File(databasePath).exists()) {
      return databasePath;
    }

    // Copy the database from assets to the document directory
    ByteData data = await rootBundle.load("assets/database/data.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(databasePath).writeAsBytes(bytes, flush: true);

    return databasePath;
  }
}
