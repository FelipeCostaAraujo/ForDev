import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/validation/validators/required_field_validation.dart';


void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any value'), null);
  });

  test('Should error if value is empty', () {
    expect(sut.validate(''), "Campo obrigatório");
  });

  test('Should error if value is null', () {
    expect(sut.validate(null), "Campo obrigatório");
  });
}
