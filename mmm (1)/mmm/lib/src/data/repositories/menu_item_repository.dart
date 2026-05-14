import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/menu_item.dart';
import '../database.dart';

class MenuItemRepository {
  final DatabaseHelper _dbHelper;

  MenuItemRepository(this._dbHelper);

  Database get _db => _dbHelper.db;

  MenuItem create(MenuItem item) {
    _db.execute(
      'INSERT INTO menu_items(name, description, price) VALUES(?, ?, ?)',
      [item.name, item.description, item.price],
    );
    final lastId = _db.lastInsertRowId;
    return MenuItem(
      id: lastId,
      name: item.name,
      description: item.description,
      price: item.price,
    );
  }

  List<MenuItem> getAll() {
    final rows = _db.select('SELECT id, name, description, price FROM menu_items');
    return rows.map((row) => MenuItem.fromMap({
      'id': row['id'],
      'name': row['name'],
      'description': row['description'],
      'price': row['price'],
    })).toList();
  }

  MenuItem? getById(int id) {
    final rows = _db.select(
      'SELECT id, name, description, price FROM menu_items WHERE id = ?',
      [id],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    return MenuItem.fromMap({
      'id': row['id'],
      'name': row['name'],
      'description': row['description'],
      'price': row['price'],
    });
  }

  MenuItem? update(MenuItem item) {
    if (item.id == null) return null;
    _db.execute(
      'UPDATE menu_items SET name = ?, description = ?, price = ? WHERE id = ?',
      [item.name, item.description, item.price, item.id],
    );
    return getById(item.id!);
  }

  void delete(int id) {
    _db.execute('DELETE FROM menu_items WHERE id = ?', [id]);
  }
}
