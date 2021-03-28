import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import './components/components.dart';
import './signup_presenter.dart';

class SignUpPage extends StatelessWidget
    with KeyboardManager, LoadingManager, UiErrorManager, NavigationManager {
  final SignUpPresenter presenter;
  SignUpPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context: context, stream: presenter.isLoadingStream);
          handleMainError(context: context, stream: presenter.mainErrorStream);
          handleNavigation(presenter.navigateToStream, clear: true);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginHeader(),
                  HeadLine(text: R.strings.addAccount),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Provider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            NameInput(),
                            SizedBox(height: 8),
                            EmailInput(),
                            SizedBox(height: 8),
                            PasswordInput(),
                            SizedBox(height: 8),
                            PasswordConfirmationInput(),
                            SizedBox(height: 22),
                            SignUpButton(),
                            FlatButton.icon(
                              onPressed: presenter.goToLogin,
                              icon: Icon(Icons.person),
                              label: Text(R.strings.login),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
