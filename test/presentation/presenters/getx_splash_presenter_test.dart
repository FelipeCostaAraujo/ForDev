
import 'package:flutter_test/flutter_test.dart';
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
    await loadCurrentAccount.load();
  }

}


class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

void main(){
  LoadCurrentAccountSpy loadCurrentAccount;
  GetXSplashPresenter sut;
  setUp((){
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
  });

  test('Should call LoadCurrentAccount', () async{
    await sut.checkAccount();
    verify(loadCurrentAccount.load()).called(1);
  });
}