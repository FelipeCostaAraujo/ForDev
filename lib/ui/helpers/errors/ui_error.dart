enum UIError{
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials
}

extension UIErrorExtension on UIError {
  String get description{
    switch(this){
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      default:
        return 'Aconteceu algo errado. Tente novamente em breve';
    }
  }
}