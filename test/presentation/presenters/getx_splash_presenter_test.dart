
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
  test('Should call LoadCurrentAccount', () async{
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}