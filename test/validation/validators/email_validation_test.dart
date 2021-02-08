import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';
import 'package:for_dev/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('felipe@futuroallu.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('any_invalid_email'), ValidationError.invalidField);
  });
}

//
