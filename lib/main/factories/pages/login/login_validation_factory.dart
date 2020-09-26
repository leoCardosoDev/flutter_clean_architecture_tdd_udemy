import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidaton('email'),
    EmailValidation('email'),
    RequiredFieldValidaton('password'),
  ]);
}
