import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../data/usecases/remote_authentication.dart';
import '../../../../intra/http/http.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/login/login.page.dart';
import '../../../../utils/settings.dart';
import '../../../../validation/validators/email_validation.dart';
import '../../../../validation/validators/required_field_validation.dart';
import '../../../../validation/validators/validation_composite.dart';


Widget makeLoginPage(){
  final url = Settings.apiUrl + "/authenticate/login";
  final client = Client();
  final httpAdapter = HttpAdapter(client);

  final remoteAuthentication = RemoteAuthentication(
      httpClient: httpAdapter,
      url: url
  );
  final validationComposite = ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ]);
  final streamLoginPresenter = StreamLoginPresenter(
      validation: validationComposite,
      authentication: remoteAuthentication
  );
  return LoginPage(streamLoginPresenter);
}