import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';

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

  void _hideKeyBoard(){
    final currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          print(isLoading);
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });

        widget.presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });

        return GestureDetector(
          onTap: _hideKeyBoard,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1(text: R.string.headlineLogin),
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
                              label: Text(R.string.addAccount))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

