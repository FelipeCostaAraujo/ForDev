enum DomainError{
  unexpected,
  invalidCredentials
}

extension DomainErrorExtension on DomainError {
  String get description{
    switch(this){
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas.';
      default:
        return 'Aconteceu algo errado. Tente novamente em breve';
    }
  }
}