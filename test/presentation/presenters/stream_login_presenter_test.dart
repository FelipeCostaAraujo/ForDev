import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/presentation/presenters/presenters.dart';
import 'package:for_dev/presentation/protocols/protocols.dart';

import 'package:for_dev/domain/entities/account_entity.dart';
import 'package:for_dev/domain/usecases/authentication.dart';

class ValidationSpy extends Mock implements Validation {}
class AuthenticationSpy extends Mock implements Authentication{}

void main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() {
    mockAuthenticationCall().thenAnswer((_) async => AccountEntity(faker.guid.guid()));
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    email = faker.internet.password();
    password = faker.internet.password();
    sut = StreamLoginPresenter(validation: validation,authentication: authentication);
    mockValidation();
    mockAuthentication();
  });

  test('Should call validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');
    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call validation with correct password', () {
    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'error');
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error as null if validation succeeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));
    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error as null if validation succeeds', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Should emit password error if validation fails', () async{
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));

    expectLater(sut.isFormValidStream, emitsInOrder([false,true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
  });

  test('Should call authentication if correct values', () async{
    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    verify(authentication.auth(AuthenticationParams(email: email, password: password))).called(1);
  });

  test('Should emit correct events on Authentication success', () async{
    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true,false]));

    await sut.auth();
  });
}
