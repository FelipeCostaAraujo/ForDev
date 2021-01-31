import '../../validation/protocols/protocols.dart';
import '../../validation/validators/validators.dart';

class ValidationsBuilder{
  static ValidationsBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  static ValidationsBuilder field(String fieldName){
    _instance = ValidationsBuilder();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationsBuilder required(){
      validations.add(RequiredFieldValidation(fieldName));
      return this;
  }

  ValidationsBuilder email(){
    validations.add(EmailValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}