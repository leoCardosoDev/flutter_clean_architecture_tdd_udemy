import '../protocols/protocols.dart';

class RequiredFieldValidaton implements FieldValidation {
  final String field;

  RequiredFieldValidaton(this.field);

  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
}
