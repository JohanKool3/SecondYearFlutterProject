import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  late Database database_connection;

  DatabaseManager(String dbPath) {
    setupDatabase(dbPath);
  }

  void setupDatabase([String? dbPath]) async {
    if (dbPath == null) {
      throw Exception("Database Path must not be null");
    } else {
      database_connection = await openDatabase(dbPath);
    }
  }
}
