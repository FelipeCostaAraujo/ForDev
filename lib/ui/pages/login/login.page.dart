import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/components.dart';
import '../../components/component.dart';

import '../login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error);
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(height: height),
              Headline1(text: 'Login'),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Column(
                      children: [
                        EmailInput(),
                        Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(),
                        ),
                        LoginButton(),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person),
                            label: Text('Criar uma conta'))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

