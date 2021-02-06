
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

import 'package:for_dev/presentation/presenters/presenters.dart';


class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

void main(){
  LoadCurrentAccountSpy loadCurrentAccount;
  GetXSplashPresenter sut;

  PostExpectation mockLoadCurrentCalls() => when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({AccountEntity account}){
    mockLoadCurrentCalls().thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError(){
    mockLoadCurrentCalls().thenThrow(Exception());
  }

  setUp((){
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async{
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async{
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));
    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async{
    mockLoadCurrentAccount(account: null);
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));
    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login on error', () async{
    mockLoadCurrentAccountError();
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));
    await sut.checkAccount(durationInSeconds: 0);
  });
}