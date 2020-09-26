import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidaton extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequiredFieldValidaton(this.field);

  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
}
