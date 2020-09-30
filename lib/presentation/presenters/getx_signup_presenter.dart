import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/helpers/errors/errors.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;

  var _emailError = Rx<UiError>();
  var _isFormValid = false.obs;

  Stream<UiError> get emailErrorStream => _emailError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSignUpPresenter({@required this.validation});

  void validateEmail(String email) {
    _emailError.value = _validateField('email');
    _validateForm();
  }

  UiError _validateField(String field) {
    final formData = {};
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UiError.invalidField;
      case ValidationError.requiredField:
        return UiError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = false;
  }
}
