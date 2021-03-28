import 'package:get/get.dart';

mixin NavigateToManager {
  final _navigateTo = RxString();
  Stream<String> get navigateToStream => _navigateTo.stream;
  set navigateTo(String value) => _navigateTo.value = value;
}
