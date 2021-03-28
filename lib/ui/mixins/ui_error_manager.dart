import 'package:flutter/material.dart';
import '../helpers/errors/errors.dart';
import '../components/components.dart';

mixin UiErrorManager {
  void handleMainError({BuildContext context, Stream<UiError> stream}) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
