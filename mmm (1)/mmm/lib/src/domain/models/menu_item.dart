
class MenuItem {
  final int? id;
  final String name;
  final String description;
  final double price;

  const MenuItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
      };

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'Меню #$id: $name — $price₽ ($description)';
}
