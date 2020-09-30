import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../components/components.dart';
import 'components/components.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currectFocus = FocusScope.of(context);
      if (currectFocus.hasPrimaryFocus) {
        currectFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginHeader(),
                  HeadLine(text: R.strings.addAccount),
                  Padding(
                    padding: const EdgeInsets.all(13),
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
                            onPressed: () {},
                            icon: Icon(Icons.exit_to_app),
                            label: Text(R.strings.login),
                          ),
                        ],
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
