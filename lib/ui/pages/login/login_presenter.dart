import '../../helpers/errors/errors.dart';

abstract class LoginPresenter{
  Stream<bool> get passwordObscureStream;
  Stream<String> get navigateToStream;
  Stream<UIError> get emailErrorStream;
  Stream<UIError> get passwordErrorStream;
  Stream<UIError> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  void dispose();
  void togglePasswordVisibility();
}