import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/presentation/protocols/protocols.dart';
import 'package:flutter_clean_architecture_tdd/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate({'any_field': 'leocardosodev@gmail.com'}), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate({'any_field': 'leocardosodev'}),
        ValidationError.invalidField);
  });
}
