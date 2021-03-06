import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

import 'package:for_dev/data/cache/cache.dart';
import 'package:for_dev/data/usecases/save_current_account/save_current_account.dart';


class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main(){
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  LocalSaveCurrentAccount sut;
  AccountEntity account;

  setUp((){
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage : saveSecureCacheStorage);
    account = AccountEntity(faker.guid.guid());
  });

  void mockError(){
    when(saveSecureCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());
  }

  test('Should call SaveSecureCacheStorage with correct values', () async{
    await sut.save(account);
    verify(saveSecureCacheStorage.saveSecure(key:'token',value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async{
    mockError();
    final future = sut.save(account);
    expect(future, throwsA(DomainError.unexpected));
  });
}