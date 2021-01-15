import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';
import './components.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          obscureText: presenter.passwordVisible == true ? true : false,
          onChanged: presenter.validatePassword,
          decoration: InputDecoration(
              labelText: 'Senha',
              suffixIcon: CustomIconButton(
                radius: 32,
                iconData: presenter.passwordVisible == true
                    ? Icons.visibility_off
                    : Icons.visibility,
                onTap: presenter.togglePasswordVisibility,
              ),
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
              icon:
                  Icon(Icons.lock, color: Theme.of(context).primaryColorLight)),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
