import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/domain/helpers/helpers.dart';

import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  AuthenticationParams params;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
  });

  test('Should call HttpClient with correct value', () async {
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });

  test('Should throw UnexpectedError if HttpClient return 400', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'),body: anyNamed('body')))
      .thenThrow(HttpError.badRequest);

    final future =  sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'),body: anyNamed('body')))
        .thenThrow(HttpError.notFound);

    final future =  sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'),body: anyNamed('body')))
        .thenThrow(HttpError.serverError);

    final future =  sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
