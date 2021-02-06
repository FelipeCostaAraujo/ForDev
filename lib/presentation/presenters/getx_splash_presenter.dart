import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class GetXSplashPresenter implements SplashPresenter{
  final LoadCurrentAccount loadCurrentAccount;

  GetXSplashPresenter({@required this.loadCurrentAccount});
  var _navigateTo = RxString();

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount({int durationInSeconds = 2}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try{
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.isNull ? '/login' : '/home';
    }catch(error){
      _navigateTo.value = '/login';
    }
  }

}