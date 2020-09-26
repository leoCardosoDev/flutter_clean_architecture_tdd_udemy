import 'package:flutter_clean_architecture_tdd/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);
  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');
    final error = sut.validate('');
    expect(error, null);
  });
}
