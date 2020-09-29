import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class RequiredFieldValidaton extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidaton(this.field);

  ValidationError validate(Map input) =>
      input[field]?.isNotEmpty == true ? null : ValidationError.requiredField;
}
