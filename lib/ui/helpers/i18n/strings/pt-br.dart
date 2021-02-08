import './strings.dart';

class PtBr implements Translations {
  String get msgRequiredField => 'Campo obrigatório';
  String get msgInvalidField => 'Campo inválido';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgUnexpectedError => 'Aconteceu algo errado. Tente novamente em breve';

  String get addAccount => 'Criar uma conta';
  String get email => 'Email';
  String get headlineLogin => 'LOGIN';
  String get password => 'Senha';
  String get signIn => 'Entrar';
}