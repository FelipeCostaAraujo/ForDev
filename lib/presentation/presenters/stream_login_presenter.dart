import 'dart:async';

import 'package:for_dev/ui/helpers/errors/ui_error.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  UIError emailError;
  UIError passwordError;
  UIError mainError;
  String navigateTo;
  bool passwordObscure = true;
  bool isLoading = false;
  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter{
  final Validation validation;
  final Authentication authentication;
  var _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<UIError> get emailErrorStream => _controller?.stream?.map((state) => state.emailError)?.distinct();
  Stream<UIError> get passwordErrorStream => _controller?.stream?.map((state) => state.passwordError)?.distinct();
  Stream<UIError> get mainErrorStream => _controller?.stream?.map((state) => state.mainError)?.distinct();
  Stream<String> get navigateToStream => _controller?.stream?.map((state) => state.navigateTo)?.distinct();
  Stream<bool> get isFormValidStream => _controller?.stream?.map((state) => state.isFormValid)?.distinct();
  Stream<bool> get isLoadingStream => _controller?.stream?.map((state) => state.isLoading)?.distinct();
  Stream<bool> get passwordObscureStream => _controller?.stream?.map((state) => state.passwordObscure)?.distinct();

  void update() => _controller?.add(_state);

  StreamLoginPresenter({@required this.validation,@required this.authentication});
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validationField(field: 'email', value: email);
    update();
  }

  void togglePasswordVisibility() {
    _state.passwordObscure = !_state.passwordObscure;
    update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validationField(field: 'password', value: password);
    update();
  }

  UIError _validationField({String field,String value}){
    final error = validation.validate(field: field, value: value);
    switch(error){
      case ValidationError.invalidField:
        return UIError.invalidField;
        break;
      case ValidationError.requiredField:
        return UIError.requiredField;
        break;
      default:
        return null;
        break;
    }
  }

  Future<void> auth() async {
    _state.isLoading = true;
    update();
    try {
      await authentication.auth(AuthenticationParams(email: _state.email, password: _state.password));
    }on DomainError catch(error){
      switch(error){
        case DomainError.invalidCredentials:
        case DomainError.invalidCredentials:
        _state.mainError = UIError.invalidCredentials;
          break;
        default:
          _state.mainError = UIError.unexpected;
      }
    }
    _state.isLoading = false;
    update();
  }

  void dispose(){
    _controller.close();
    _controller = null;
  }
}
