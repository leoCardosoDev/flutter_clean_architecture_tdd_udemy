import 'package:get/get.dart';

import '../../ui/helpers/errors/errors.dart';

mixin UiErrorManager on GetxController {
  final _mainError = Rx<UiError>();
  Stream<UiError> get mainErrorStream => _mainError.stream;
  set mainError(UiError value) => _mainError.value = value;
}
