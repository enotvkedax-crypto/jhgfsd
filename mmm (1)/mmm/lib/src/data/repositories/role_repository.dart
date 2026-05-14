import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/role.dart';
import '../database.dart';

class RoleRepository {
  final DatabaseHelper _dbHelper;

  RoleRepository(this._dbHelper);

  Database get _db => _dbHelper.db;

  Role create(Role role) {
    _db.execute(
      'INSERT INTO roles(name) VALUES(?)',
      [role.name],
    );
    final lastId = _db.lastInsertRowId;
    return Role(id: lastId, name: role.name);
  }

  List<Role> getAll() {
    final rows = _db.select('SELECT id, name FROM roles');
    return rows.map((row) => Role.fromMap({'id': row['id'], 'name': row['name']})).toList();
  }

  Role? getById(int id) {
    final rows = _db.select(
      'SELECT id, name FROM roles WHERE id = ?',
      [id],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    return Role.fromMap({'id': row['id'], 'name': row['name']});
  }

  Role? update(Role role) {
    if (role.id == null) return null;
    _db.execute(
      'UPDATE roles SET name = ? WHERE id = ?',
      [role.name, role.id],
    );
    return getById(role.id!);
  }

  void delete(int id) {
    _db.execute('DELETE FROM roles WHERE id = ?', [id]);
  }
}
