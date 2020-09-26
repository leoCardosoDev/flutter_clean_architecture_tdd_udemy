import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidaton implements FieldValidation {
  final String field;

  RequiredFieldValidaton(this.field);

  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if value is not empty', () {
    final sut = RequiredFieldValidaton('any_field');

    final error = sut.validate('any_value');

    expect(error, null);
  });
}
