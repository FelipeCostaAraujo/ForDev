import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../login_presenter.dart';
import './components.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return StreamBuilder<bool>(
          stream: presenter.passwordObscureStream,
          builder: (context, snapshotVisible){
            bool obscure = true;
            if(snapshotVisible.hasData){
              snapshotVisible?.data == true ? obscure = true : obscure = false;
            }
            return TextFormField(
              obscureText: obscure,
              onChanged: presenter.validatePassword,
              decoration: InputDecoration(
                  labelText: R.string.password,
                  suffixIcon: CustomIconButton(
                    radius: 32,
                    iconData: obscure ? Icons.visibility : Icons.visibility_off,
                    onTap: presenter.togglePasswordVisibility,
                  ),
                  errorText: snapshot.hasData ? snapshot.data.description : null,
                  icon:
                  Icon(Icons.lock, color: Theme.of(context).primaryColorLight)),
              keyboardType: TextInputType.emailAddress,
            );
          }
        );
      },
    );
  }
}
