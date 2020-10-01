import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
  test('Should return error if value is empty', () {
    final sut = MinLengthValidation(field: 'any_field', size: 5);
    final error = sut.validate({});
    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final sut = MinLengthValidation(field: 'any_field', size: 5);
    final error = sut.validate(null);
    expect(error, ValidationError.invalidField);
  });
}
