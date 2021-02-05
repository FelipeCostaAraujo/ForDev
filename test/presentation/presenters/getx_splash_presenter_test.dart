
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/load_current_account.dart';
import 'package:for_dev/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:meta/meta.dart';

class GetXSplashPresenter implements SplashPresenter{
  final LoadCurrentAccount loadCurrentAccount;

  GetXSplashPresenter({@required this.loadCurrentAccount});
  var _navigateTo = RxString();
  
  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();
    _navigateTo.value = account.isNull ? '/login' : '/home';
  }

}


class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

void main(){
  LoadCurrentAccountSpy loadCurrentAccount;
  GetXSplashPresenter sut;

  void mockLoadCurrentAccount({AccountEntity account}){
    when(loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  setUp((){
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async{
    await sut.checkAccount();
    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to home page on success', () async{
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));
    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async{
    mockLoadCurrentAccount(account: null);
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));
    await sut.checkAccount();
  });

  // test('Should go to home page on success', () async{
  //   sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/home')));
  //   await sut.checkAccount();
  // });
}