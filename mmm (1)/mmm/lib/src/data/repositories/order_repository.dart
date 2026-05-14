import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/order.dart';
import '../database.dart';

class OrderRepository {
  final DatabaseHelper _dbHelper;

  OrderRepository(this._dbHelper);

  Database get _db => _dbHelper.db;

  Order create(Order order) {
    _db.execute(
      'INSERT INTO orders(userId, menuItemId, quantity, orderDate) VALUES(?, ?, ?, ?)',
      [order.userId, order.menuItemId, order.quantity, order.orderDate.toIso8601String()],
    );
    final lastId = _db.lastInsertRowId;
    return Order(
      id: lastId,
      userId: order.userId,
      menuItemId: order.menuItemId,
      quantity: order.quantity,
      orderDate: order.orderDate,
    );
  }

  List<Order> getAll() {
    final rows = _db.select('SELECT id, userId, menuItemId, quantity, orderDate FROM orders');
    return rows.map((row) => Order.fromMap({
      'id': row['id'],
      'userId': row['userId'],
      'menuItemId': row['menuItemId'],
      'quantity': row['quantity'],
      'orderDate': row['orderDate'],
    })).toList();
  }

  Order? getById(int id) {
    final rows = _db.select(
      'SELECT id, userId, menuItemId, quantity, orderDate FROM orders WHERE id = ?',
      [id],
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    return Order.fromMap({
      'id': row['id'],
      'userId': row['userId'],
      'menuItemId': row['menuItemId'],
      'quantity': row['quantity'],
      'orderDate': row['orderDate'],
    });
  }


  Order? update(Order order) {
    if (order.id == null) return null;
    _db.execute(
      'UPDATE orders SET userId = ?, menuItemId = ?, quantity = ?, orderDate = ? WHERE id = ?',
      [order.userId, order.menuItemId, order.quantity, order.orderDate.toIso8601String(), order.id],
    );
    return getById(order.id!);
  }

  void delete(int id) {
    _db.execute('DELETE FROM orders WHERE id = ?', [id]);
  }
}
