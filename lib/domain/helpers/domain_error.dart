enum DomainError{
  unexpected,
  invalidCredentials
}

extension DomainErrorExtension on DomainError {
  String get description{
    switch(this){
      case DomainError.invalidCredentials:
        return 'Invalid Credentials.';
      default:
        return 'Something wrong has happened. Try again soon';
    }
  }
}