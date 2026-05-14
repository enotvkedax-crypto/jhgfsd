
class TextValidator {
  static String? validateRequired(String? value, [String fieldName = 'Поле']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может быть пустым';
    }
    return null;
  }

  static String? validateNonEmptyTrimmed(String? value, [String fieldName = 'Поле']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName не может состоять только из пробелов';
    }
    return null;
  }
}
