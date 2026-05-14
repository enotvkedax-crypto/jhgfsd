import 'dart:io';
import '../domain/validators/text_validator.dart';
import '../domain/validators/number_validator.dart';
import '../domain/validators/date_time_validator.dart';

class InputHelper {
  static String askString(String label) {
    while (true) {
      stdout.write(label);
      final value = stdin.readLineSync();
      final error = TextValidator.validateNonEmptyTrimmed(value, label.replaceAll(':', '').trim());
      if (error == null) return value!.trim();
      stdout.writeln('  Ошибка: $error');
    }
  }

  static int askPositiveInt(String label) {
    while (true) {
      stdout.write(label);
      final value = stdin.readLineSync();
      final error = NumberValidator.validatePositiveInt(value, label.replaceAll(':', '').trim());
      if (error == null) return int.parse(value!.trim());
      stdout.writeln('  Ошибка: $error');
    }
  }

  static double askPositiveDouble(String label) {
    while (true) {
      stdout.write(label);
      final value = stdin.readLineSync();
      final error = NumberValidator.validatePositiveDouble(value, label.replaceAll(':', '').trim());
      if (error == null) return double.parse(value!.trim().replaceAll(',', '.'));
      stdout.writeln('  Ошибка: $error');
    }
  }

  static DateTime askDateTime(String label) {
    while (true) {
      stdout.write(label);
      final value = stdin.readLineSync();
      final error = DateTimeValidator.validateDateTime(value, label.replaceAll(':', '').trim());
      if (error == null) return DateTime.parse(value!.trim());
      stdout.writeln('  Ошибка: $error');
    }
  }

  static int askId(String label) {
    return askPositiveInt(label);
  }

  static String askChoice(String label) {
    stdout.write(label);
    return stdin.readLineSync()?.trim() ?? '';
  }
}