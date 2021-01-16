import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({@required this.validation});
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  setUp((){
    validation = ValidationSpy();
    email = faker.internet.password();
    sut = StreamLoginPresenter(validation: validation);
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

}
