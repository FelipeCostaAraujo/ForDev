import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';


SplashPresenter makeGetXSplashPresenter(){
  return GetXSplashPresenter(
      loadCurrentAccount: makeLocalLoadCurrentAccount()
  );
}
