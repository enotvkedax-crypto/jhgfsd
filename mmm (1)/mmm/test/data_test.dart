import 'package:test/test.dart';
import 'package:mmm/mmm.dart';

void main() {
  test('RoleRepository create и getById работают', () {
    final db = DatabaseHelper.inMemory();
    final repo = RoleRepository(db);

    final role = repo.create(Role(name: 'Официант'));
    final fromDb = repo.getById(role.id!);

    expect(fromDb, isNotNull);
    expect(fromDb!.name, equals('Официант'));

    db.close();
  });
}