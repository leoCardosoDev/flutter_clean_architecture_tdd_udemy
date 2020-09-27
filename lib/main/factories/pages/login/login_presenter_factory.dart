import '../../../../presentation/presenters/presenter.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation(),
      saveCurrentAccount: makeLocalSaveCurrentAccount());
}
