import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  final Database _db;

  DatabaseHelper(String filePath) : _db = sqlite3.open(filePath) {
    _createTables();
  }

  factory DatabaseHelper.inApp() {
    final filePath = p.join(Directory.current.path, 'restaurant.db');
    return DatabaseHelper(filePath);
  }

  factory DatabaseHelper.inMemory() {
    return DatabaseHelper(':memory:');
  }

  Database get db => _db;

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS roles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        phone TEXT NOT NULL,
        roleId INTEGER NOT NULL,
        FOREIGN KEY (roleId) REFERENCES roles(id) ON DELETE RESTRICT
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS menu_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        menuItemId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        orderDate TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (menuItemId) REFERENCES menu_items(id) ON DELETE CASCADE
      );
    ''');
  }

  void close() {
    _db.dispose();
  }
}
