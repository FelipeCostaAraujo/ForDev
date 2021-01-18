import 'dart:async';

import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  void update() => _controller.add(_state);

  StreamLoginPresenter({@required this.validation,@required this.authentication});
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    update();
  }

  Future<void> auth() async {
    await authentication.auth(AuthenticationParams(email: _state.email, password: _state.password));
  }
}
