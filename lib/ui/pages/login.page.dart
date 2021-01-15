import 'package:flutter/material.dart';

import '../components/component.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      body: SingleChildScrollView(
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
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'fordev@fordev.com',
                          icon: Icon(Icons.email,
                              color: Theme.of(context).primaryColorLight)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                            labelText: 'Senha',
                            suffixIcon: CustomIconButton(
                              radius: 32,
                              iconData: _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onTap: _togglePasswordVisibility,
                            ),
                            icon: Icon(Icons.lock,
                                color: Theme.of(context).primaryColorLight)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("Entrar".toUpperCase()),
                    ),
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
      ),
    );
  }

  _togglePasswordVisibility(){
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
