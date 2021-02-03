import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeStreamLoginPresenter(){
  return StreamLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication()
  );
}

LoginPresenter makeGetXLoginPresenter(){
  return GetXLoginPresenter(
      validation: makeLoginValidation(),
      authentication: makeRemoteAuthentication(),
      saveCurrentAccount: makeLocalSaveCurrentAccount()
  );
}
