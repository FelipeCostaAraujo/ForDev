import './strings.dart';

class EnUs implements Translations {
  String get msgRequiredField => 'Required field';
  String get msgInvalidField => 'Invalid field';
  String get msgInvalidCredentials => 'Invalid credentials.';
  String get msgUnexpectedError => 'Something went wrong. Please try again soon';

  String get addAccount => 'Add account';
  String get email => 'E-mail';
  String get headlineLogin => 'LOGIN';
  String get password => 'Password';
  String get signIn => 'Sign in';
}