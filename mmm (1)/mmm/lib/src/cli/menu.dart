import 'dart:io';
import '../data/database.dart';
import '../data/repositories/role_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/repositories/menu_item_repository.dart';
import '../data/repositories/order_repository.dart';
import '../domain/models/role.dart';
import '../domain/models/user.dart';
import '../domain/models/menu_item.dart';
import '../domain/models/order.dart';
import 'input_helper.dart';

class Menu {
  late final DatabaseHelper _db;
  late final RoleRepository _roleRepo;
  late final UserRepository _userRepo;
  late final MenuItemRepository _menuItemRepo;
  late final OrderRepository _orderRepo;

  Menu() {
    _db = DatabaseHelper.inApp();
    _roleRepo = RoleRepository(_db);
    _userRepo = UserRepository(_db);
    _menuItemRepo = MenuItemRepository(_db);
    _orderRepo = OrderRepository(_db);
  }

  Menu.withDb(this._db) {
    _roleRepo = RoleRepository(_db);
    _userRepo = UserRepository(_db);
    _menuItemRepo = MenuItemRepository(_db);
    _orderRepo = OrderRepository(_db);
  }

  void run() {
    while (true) {
      stdout.writeln("Ресторан - Управление ");
      stdout.writeln("Роль:");
      stdout.writeln("  1  - Список ролей");
      stdout.writeln("  2  - Добавить роль");
      stdout.writeln("  3  - Обновить роль");
      stdout.writeln("  4  - Удалить роль");
      stdout.writeln("Пользователи:");
      stdout.writeln("  5  - Список пользователей");
      stdout.writeln("  6  - Добавить пользователя");
      stdout.writeln("  7  - Обновить пользователя");
      stdout.writeln("  8  - Удалить пользователя");
      stdout.writeln("Меню:");
      stdout.writeln("  9  - Список пунктов меню");
      stdout.writeln("  10 - Добавить пункт меню");
      stdout.writeln("  11 - Обновить пункт меню");
      stdout.writeln("  12 - Удалить пункт меню");
      stdout.writeln("Заказы:");
      stdout.writeln("  13 - Список заказов");
      stdout.writeln("  14 - Добавить заказ");
      stdout.writeln("  15 - Обновить заказ");
      stdout.writeln("  16 - Удалить заказ");
      stdout.writeln("БД:");
      stdout.writeln("  17 - Показать ВСЁ из БД");
      stdout.writeln("  18 - Удалить ВСЁ из БД");
      stdout.writeln("  0  - Выход");
      stdout.write("Выберите пункт: ");

      final choice = InputHelper.askChoice('');
      switch (choice) {
        case '1': _printRoles(); break;
        case '2': _addRole(); break;
        case '3': _updateRole(); break;
        case '4': _deleteRole(); break;
        case '5': _printUsers(); break;
        case '6': _addUser(); break;
        case '7': _updateUser(); break;
        case '8': _deleteUser(); break;
        case '9': _printMenuItems(); break;
        case '10': _addMenuItem(); break;
        case '11': _updateMenuItem(); break;
        case '12': _deleteMenuItem(); break;
        case '13': _printOrders(); break;
        case '14': _addOrder(); break;
        case '15': _updateOrder(); break;
        case '16': _deleteOrder(); break;
        case '17': _printAllFromDb(); break;
        case '18': _deleteAllFromDb(); break;
        case '0':
          stdout.writeln('До свидания!');
          return;
        default:
          stdout.writeln('Неизвестная команда');
      }
      stdout.writeln();
    }
  }

  void _printRoles() {
    final list = _roleRepo.getAll();
    if (list.isEmpty) { stdout.writeln('Ролей нет'); return; }
    stdout.writeln('Роли');
    for (final r in list) {
      stdout.writeln('  id: ${r.id} | ${r.name}');
    }
  }

  void _addRole() {
    final name = InputHelper.askString('Название роли: ');
    final role = _roleRepo.create(Role(name: name));
    stdout.writeln('Роль создана: $role');
  }

  void _updateRole() {
    _printRoles();
    final id = InputHelper.askId('ID роли для обновления: ');
    final existing = _roleRepo.getById(id);
    if (existing == null) { stdout.writeln('Роль с ID $id не найдена.'); return; }
    final name = InputHelper.askString('Новое название роли: ');
    final updated = _roleRepo.update(Role(id: id, name: name));
    stdout.writeln('Роль обновлена: $updated');
  }

  void _deleteRole() {
    _printRoles();
    final id = InputHelper.askId('ID роли для удаления: ');
    _roleRepo.delete(id);
    stdout.writeln('Роль удалена (если ID существовал).');
  }

  void _printUsers() {
    final list = _userRepo.getAll();
    if (list.isEmpty) { stdout.writeln('Пользователей нет.'); return; }
    stdout.writeln(' Пользователи');
    for (final u in list) {
      final role = _roleRepo.getById(u.roleId);
      final roleName = role?.name ?? '???';
      stdout.writeln('  id: ${u.id} | ${u.fullName} | тел: ${u.phone} | роль: $roleName');
    }
  }

  void _addUser() {
    stdout.writeln('Доступные роли:');
    _printRoles();
    final fullName = InputHelper.askString('ФИО пользователя: ');
    final phone = InputHelper.askString('Телефон: ');
    final roleId = InputHelper.askId('ID роли: ');
    if (_roleRepo.getById(roleId) == null) {
      stdout.writeln('Роль с ID $roleId не найдена!');
      return;
    }
    final user = _userRepo.create(User(fullName: fullName, phone: phone, roleId: roleId));
    stdout.writeln('Пользователь создан: $user');
  }

  void _updateUser() {
    _printUsers();
    final id = InputHelper.askId('ID пользователя для обновления: ');
    final existing = _userRepo.getById(id);
    if (existing == null) { stdout.writeln('Пользователь с ID $id не найден.'); return; }
    final fullName = InputHelper.askString('Новое ФИО: ');
    final phone = InputHelper.askString('Новый телефон: ');
    stdout.writeln('Доступные роли:');
    _printRoles();
    final roleId = InputHelper.askId('Новый ID роли: ');
    if (_roleRepo.getById(roleId) == null) {
      stdout.writeln('Роль с ID $roleId не найдена!');
      return;
    }
    final updated = _userRepo.update(User(id: id, fullName: fullName, phone: phone, roleId: roleId));
    stdout.writeln('Пользователь обновлён: $updated');
  }

  void _deleteUser() {
    _printUsers();
    final id = InputHelper.askId('ID пользователя для удаления: ');
    _userRepo.delete(id);
    stdout.writeln('Пользователь удалён (если ID существовал).');
  }

  void _printMenuItems() {
    final list = _menuItemRepo.getAll();
    if (list.isEmpty) { stdout.writeln('Пунктов меню нет.'); return; }
    stdout.writeln(' Меню ');
    for (final m in list) {
      stdout.writeln('  id: ${m.id} | ${m.name} | ${m.price} руб | ${m.description}');
    }
  }

  void _addMenuItem() {
    final name = InputHelper.askString('Название блюда: ');
    final description = InputHelper.askString('Описание: ');
    final price = InputHelper.askPositiveDouble('Цена: ');
    final item = _menuItemRepo.create(MenuItem(name: name, description: description, price: price));
    stdout.writeln('Пункт меню создан: $item');
  }

  void _updateMenuItem() {
    _printMenuItems();
    final id = InputHelper.askId('ID пункта меню для обновления: ');
    final existing = _menuItemRepo.getById(id);
    if (existing == null) { stdout.writeln('Пункт меню с ID $id не найден.'); return; }
    final name = InputHelper.askString('Новое название: ');
    final description = InputHelper.askString('Новое описание: ');
    final price = InputHelper.askPositiveDouble('Новая цена: ');
    final updated = _menuItemRepo.update(MenuItem(id: id, name: name, description: description, price: price));
    stdout.writeln('Пункт меню обновлён: $updated');
  }

  void _deleteMenuItem() {
    _printMenuItems();
    final id = InputHelper.askId('ID пункта меню для удаления: ');
    _menuItemRepo.delete(id);
    stdout.writeln('Пункт меню удалён (если ID существовал).');
  }

  void _printOrders() {
    final list = _orderRepo.getAll();
    if (list.isEmpty) { stdout.writeln('Заказов нет'); return; }
    stdout.writeln(' Заказы');
    for (final o in list) {
      final user = _userRepo.getById(o.userId);
      final menuItem = _menuItemRepo.getById(o.menuItemId);
      final userName = user?.fullName ?? '???';
      final menuName = menuItem?.name ?? '???';
      stdout.writeln('  id: ${o.id} | пользователь: $userName | блюдо: $menuName | кол-во: ${o.quantity} | дата: ${o.orderDate.toLocal()}');
    }
  }

  void _addOrder() {
    stdout.writeln('Доступные пользователи:');
    _printUsers();
    stdout.writeln('Доступные пункты меню:');
    _printMenuItems();
    final userId = InputHelper.askId('ID пользователя: ');
    if (_userRepo.getById(userId) == null) {
      stdout.writeln('Пользователь с ID $userId не найден');
      return;
    }
    final menuItemId = InputHelper.askId('ID пункта меню: ');
    if (_menuItemRepo.getById(menuItemId) == null) {
      stdout.writeln('Пункт меню с ID $menuItemId не найден');
      return;
    }
    final quantity = InputHelper.askPositiveInt('Количество: ');
    final orderDate = InputHelper.askDateTime('Дата заказа (например 2026-05-07 14:30): ');
    final order = _orderRepo.create(Order(userId: userId, menuItemId: menuItemId, quantity: quantity, orderDate: orderDate));
    stdout.writeln('Заказ создан: $order');
  }

  void _updateOrder() {
    _printOrders();
    final id = InputHelper.askId('ID заказа для обновления: ');
    final existing = _orderRepo.getById(id);
    if (existing == null) { stdout.writeln('Заказ с ID $id не найден.'); return; }
    stdout.writeln('Доступные пользователи:');
    _printUsers();
    final userId = InputHelper.askId('Новый ID пользователя: ');
    if (_userRepo.getById(userId) == null) {
      stdout.writeln('Пользователь с ID $userId не найден');
      return;
    }
    stdout.writeln('Доступные пункты меню:');
    _printMenuItems();
    final menuItemId = InputHelper.askId('Новый ID пункта меню: ');
    if (_menuItemRepo.getById(menuItemId) == null) {
      stdout.writeln('Пункт меню с ID $menuItemId не найден!');
      return;
    }
    final quantity = InputHelper.askPositiveInt('Новое количество: ');
    final orderDate = InputHelper.askDateTime('Новая дата заказа: ');
    final updated = _orderRepo.update(Order(id: id, userId: userId, menuItemId: menuItemId, quantity: quantity, orderDate: orderDate));
    stdout.writeln('Заказ обновлён: $updated');
  }

  void _deleteOrder() {
    _printOrders();
    final id = InputHelper.askId('ID заказа для удаления: ');
    _orderRepo.delete(id);
    stdout.writeln('Заказ удалён (если ID существовал).');
  }

  void _printAllFromDb() {
    stdout.writeln();
    stdout.writeln('Все из бд');
    stdout.writeln();
    _printRoles();
    stdout.writeln();
    _printUsers();
    stdout.writeln();
    _printMenuItems();
    stdout.writeln();
    _printOrders();
    stdout.writeln();
    stdout.writeln('=========================================');
  }

  void _deleteAllFromDb() {
    stdout.writeln();
    stdout.writeln('Внимание! Все данные будут удалены');
    stdout.writeln('  1 - Да, удалить всё');
    stdout.writeln('  0 - Отмена');
    stdout.write('Ваш выбор: ');
    final confirm = stdin.readLineSync()?.trim() ?? '';
    if (confirm != '1') {
      stdout.writeln('Операция отменена');
      return;
    }

    final orders = _orderRepo.getAll();
    for (final o in orders) {
      _orderRepo.delete(o.id!);
    }
    final users = _userRepo.getAll();
    for (final u in users) {
      _userRepo.delete(u.id!);
    }
    final menuItems = _menuItemRepo.getAll();
    for (final m in menuItems) {
      _menuItemRepo.delete(m.id!);
    }
    final roles = _roleRepo.getAll();
    for (final r in roles) {
      _roleRepo.delete(r.id!);
    }
    stdout.writeln('Все данные удалены из базы');
  }
}
