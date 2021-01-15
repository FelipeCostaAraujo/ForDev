import 'package:flutter/material.dart';

import '../../components/component.dart';
import '../login/login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      body: Builder(builder: (context) {

        presenter.isLoadingStream.listen((isLoading) {
          if(isLoading){
            showDialog(context: context,barrierDismissible: false,child: SimpleDialog(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Aguarde...',textAlign: TextAlign.center)
                  ],
                )
              ],
            ));
          }else{
            if(Navigator.canPop(context)){
              Navigator.of(context).pop();
            }
          }
        });

        presenter.mainErrorStream.listen((error) {
          if(error != null){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(error,textAlign: TextAlign.center,)
              )
            );
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
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                                icon: Icon(Icons.email,
                                    color:
                                        Theme.of(context).primaryColorLight)),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: presenter.validateEmail,
                          );
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                                decoration: InputDecoration(
                                    labelText: 'Senha',
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                    icon: Icon(Icons.lock,
                                        color: Theme.of(context)
                                            .primaryColorLight)),
                                keyboardType: TextInputType.emailAddress,
                              );
                            },
                          )),
                      StreamBuilder(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              onPressed:
                                  snapshot.data == true ? presenter.auth : null,
                              child: Text("Entrar".toUpperCase()),
                            );
                          }),
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
              )
            ],
          ),
        );
      }),
    );
  }
}

// _togglePasswordVisibility(){
//   setState(() {
//     _passwordVisible = !_passwordVisible;
//   });
// }
//
// suffixIcon: CustomIconButton(
// radius: 32,
// iconData: _passwordVisible
// ? Icons.visibility_off
//     : Icons.visibility,
// onTap: _togglePasswordVisibility,
// )
