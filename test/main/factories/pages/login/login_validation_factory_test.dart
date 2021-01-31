import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/main/factories/factories.dart';
import 'package:for_dev/validation/validators/validators.dart';

void main(){
  test('Should return the correct validations', (){
    final validations = makeLoginValidations();
    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}