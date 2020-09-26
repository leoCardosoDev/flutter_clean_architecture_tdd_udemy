import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/validation/validators/validators.dart';
import 'package:flutter_clean_architecture_tdd/main/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [
      RequiredFieldValidaton('email'),
      EmailValidation('email'),
      RequiredFieldValidaton('password'),
    ]);
  });
}
