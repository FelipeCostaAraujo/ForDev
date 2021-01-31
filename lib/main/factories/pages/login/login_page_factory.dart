import 'package:flutter/material.dart';

import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

Widget makeLoginPage(){
  return LoginPage(makeGetXLoginPresenter());
}
