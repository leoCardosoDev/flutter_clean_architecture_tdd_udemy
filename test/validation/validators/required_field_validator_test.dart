import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/validation/validators/validators.dart';

void main() {
  RequiredFieldValidaton sut;

  setUp(() {
    sut = RequiredFieldValidaton('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), 'Campo obrigatório');
  });
}
