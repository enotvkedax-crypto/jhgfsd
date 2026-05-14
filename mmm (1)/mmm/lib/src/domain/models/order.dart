
class Order {
  final int? id;
  final int userId;
  final int menuItemId;
  final int quantity;
  final DateTime orderDate;

  const Order({
    this.id,
    required this.userId,
    required this.menuItemId,
    required this.quantity,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'menuItemId': menuItemId,
        'quantity': quantity,
        'orderDate': orderDate.toIso8601String(),
      };

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int?,
      userId: map['userId'] as int,
      menuItemId: map['menuItemId'] as int,
      quantity: map['quantity'] as int,
      orderDate: DateTime.parse(map['orderDate'] as String),
    );
  }

  @override
  String toString() =>
      'Заказ #$id: пользователь=$userId, блюдо=$menuItemId, кол-во=$quantity, дата=$orderDate';
}
