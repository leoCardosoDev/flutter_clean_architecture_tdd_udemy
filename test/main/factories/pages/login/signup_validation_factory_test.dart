import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/validation/validators/validators.dart';
import 'package:flutter_clean_architecture_tdd/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();
    expect(validations, [
      RequiredFieldValidaton('name'),
      MinLengthValidation(field: 'name', size: 3),
      RequiredFieldValidaton('email'),
      EmailValidation('email'),
      RequiredFieldValidaton('password'),
      MinLengthValidation(field: 'password', size: 3),
      RequiredFieldValidaton('passwordConfirmation'),
      CompareFieldsValidation(
          field: 'passwordConfirmation', fieldToCompare: 'password'),
    ]);
  });
}
