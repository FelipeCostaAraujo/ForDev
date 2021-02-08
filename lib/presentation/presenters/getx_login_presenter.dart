import '../protocols/validation.dart';

import 'package:get/state_manager.dart';
import 'package:meta/meta.dart';

import '../../ui/pages/pages.dart';
import '../../ui/helpers/errors/errors.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetXLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;
  var _emailError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _mainError = Rx<UIError>();
  var _navigationTo = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;
  var _passwordObscure = true.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get mainErrorStream => _mainError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<bool> get passwordObscureStream => _passwordObscure.stream;
  Stream<String> get navigateToStream => _navigationTo.stream;

  GetXLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validationField(field: 'email', value: email);
    _validateForm();
  }

  void togglePasswordVisibility(){
    _passwordObscure.value = !_passwordObscure.value;
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validationField(field: 'password', value: password);
    _validateForm();
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


  void _validateForm() {
    _isFormValid.value = _emailError.value == null
        && _passwordError.value == null
        && _email != null
        && _password != null;
  }

  Future<void> auth() async {
    try {
      _isLoading.value = true;
      final account = await authentication.auth(AuthenticationParams(email: _email, password: _password));
      await saveCurrentAccount.save(account);
      _navigationTo.value = '/home';
    } on DomainError catch (error) {
      switch(error){
        case DomainError.invalidCredentials:
          _mainError.value = UIError.invalidCredentials;
          break;
        default:
          _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  void dispose() {}
}