import 'package:test/test.dart';
import 'package:mmm/mmm.dart';

void main() {
  test('Валидация: валидные и невалидные значения', () {
    expect(TextValidator.validateNonEmptyTrimmed('   '), isNotNull);
    expect(TextValidator.validateNonEmptyTrimmed('Текст'), isNull);

    expect(NumberValidator.validatePositiveInt('-1'), isNotNull);
    expect(NumberValidator.validatePositiveInt('5'), isNull);
  });
}