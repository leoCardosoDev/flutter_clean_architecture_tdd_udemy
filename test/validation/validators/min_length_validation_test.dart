import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_architecture_tdd/presentation/protocols/protocols.dart';
import 'package:flutter_clean_architecture_tdd/validation/protocols/field_validation.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final String field;
  final int size;
  List get props => [field, size];

  MinLengthValidation({@required this.field, @required this.size});
  ValidationError validate(Map input) => ValidationError.invalidField;
}

void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate({'any_field': ''}), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    expect(sut.validate({'any_field': null}), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate({'any_field': faker.randomGenerator.string(4, min: 1)}),
        ValidationError.invalidField);
  });
}
