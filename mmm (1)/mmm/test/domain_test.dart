import 'package:test/test.dart';
import 'package:mmm/mmm.dart';

void main() {
  test('User toMap / fromMap корректно работает', () {
    final user = User(
      id: 1,
      fullName: 'Иван Иванов',
      phone: '+79990000000',
      roleId: 2,
    );

    final map = user.toMap();
    final restored = User.fromMap(map);

    expect(restored.id, equals(user.id));
    expect(restored.fullName, equals(user.fullName));
    expect(restored.phone, equals(user.phone));
    expect(restored.roleId, equals(user.roleId));
  });
}