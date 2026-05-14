
class Role {
  final int? id;
  final String name;

  const Role({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as int?,
      name: map['name'] as String,
    );
  }

  @override
  String toString() => 'Роль #$id: $name';
}
