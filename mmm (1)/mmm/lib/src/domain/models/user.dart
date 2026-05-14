
class User {
  final int? id;
  final String fullName;
  final String phone;
  final int roleId;

  const User({
    this.id,
    required this.fullName,
    required this.phone,
    required this.roleId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'phone': phone,
        'roleId': roleId,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      roleId: map['roleId'] as int,
    );
  }

  @override
  String toString() => 'Пользователь #$id: $fullName, тел: $phone, роль: $roleId';
}
