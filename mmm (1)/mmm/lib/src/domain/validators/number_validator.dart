
class NumberValidator {
  static String? validatePositiveDouble(String? value, [String fieldName = 'Значение']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
    if (parsed == null) {
      return '$fieldName должно быть числом';
    }
    if (parsed <= 0) {
      return '$fieldName должно быть больше 0';
    }
    return null;
  }

  static String? validatePositiveInt(String? value, [String fieldName = 'Значение']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null) {
      return '$fieldName должно быть целым числом';
    }
    if (parsed <= 0) {
      return '$fieldName должно быть больше 0';
    }
    return null;
  }
}
