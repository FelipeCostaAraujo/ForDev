import '../helpers.dart';

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
        return R.string.msgInvalidCredentials;
      case UIError.requiredField:
        return R.string.msgRequiredField;
      case UIError.invalidField:
        return R.string.msgInvalidField;
      default:
        return R.string.msgUnexpectedError;
    }
  }
}