import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../login_presenter.dart';
import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError>(
      stream: presenter.emailErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: R.string.email,
              errorText: snapshot.hasData ? snapshot.data.description : null,
              icon: Icon(Icons.email,
                  color: Theme.of(context).primaryColorLight)),
          keyboardType: TextInputType.emailAddress,
          onChanged: presenter.validateEmail,
        );
      },
    );
  }
}
