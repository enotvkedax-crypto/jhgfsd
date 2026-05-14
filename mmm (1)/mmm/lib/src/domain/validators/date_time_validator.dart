
class DateTimeValidator {
  static String? validateDateTime(String? value, [String fieldName = 'Дата']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустой';
    }
    final parsed = DateTime.tryParse(value.trim());
    if (parsed == null) {
      return '$fieldName имеет некорректный формат (ожидается: 2026-05-07 14:30 или 2026-05-07T14:30:00)';
    }
    return null;
  }
}
