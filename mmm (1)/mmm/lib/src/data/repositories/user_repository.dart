import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/user.dart';
import '../database.dart';

class UserRepository {
  final DatabaseHelper _dbHelper;

  UserRepository(this._dbHelper);

  Database get _db => _dbHelper.db;

  User create(User user) {
    _db.execute(
      'INSERT INTO users(fullName, phone, roleId) VALUES(?, ?, ?)',
      [user.fullName, user.phone, user.roleId],
    );
    final lastId = _db.lastInsertRowId;
    return User(
      id: lastId,
      fullName: user.fullName,
      phone: user.phone,
      roleId: user.roleId,
    );
  }

  List<User> getAll() {
    final rows = _db.select('SELECT id, fullName, phone, roleId FROM users');
    return rows.map((row) => User.fromMap({
      'id': row['id'],
      'fullName': row['fullName'],
      'phone': row['phone'],
      'roleId': row['roleId'],
    })).toList();
  }

  User? getById(int id) {
    final rows = _db.select(
      'SELECT id, fullName, phone, roleId FROM users WHERE id = ?',
      [id],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    return User.fromMap({
      'id': row['id'],
      'fullName': row['fullName'],
      'phone': row['phone'],
      'roleId': row['roleId'],
    });
  }

  User? update(User user) {
    if (user.id == null) return null;
    _db.execute(
      'UPDATE users SET fullName = ?, phone = ?, roleId = ? WHERE id = ?',
      [user.fullName, user.phone, user.roleId, user.id],
    );
    return getById(user.id!);
  }

  void delete(int id) {
    _db.execute('DELETE FROM users WHERE id = ?', [id]);
  }
}
