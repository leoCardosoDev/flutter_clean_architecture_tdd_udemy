import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture_tdd/ui/helpers/errors/errors.dart';

import 'package:flutter_clean_architecture_tdd/presentation/presenters/presenter.dart';
import 'package:flutter_clean_architecture_tdd/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  GetxSignUpPresenter sut;
  ValidationSpy validation;
  String email;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      input: anyNamed('input')));
  void mockValidation({String field, ValidationError value}) {
    mockValidationCall(field).thenReturn((value));
  }

  setUp(() {
    validation = ValidationSpy();
    sut = GetxSignUpPresenter(
      validation: validation,
    );
    email = faker.internet.email();
    mockValidation();
  });
  test('Should call Validation with correct email', () {
    final formData = {};

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UiError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
