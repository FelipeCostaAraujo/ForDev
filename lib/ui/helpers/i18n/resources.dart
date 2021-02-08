import 'package:flutter/widgets.dart';

import 'strings/strings.dart';

class R {
  static Translations string = PtBr();
  static void load(Locale locale){
    switch(locale.toString()){
      case 'en_US':
        string = EnUs();
        break;
      default:
        string = PtBr();
        break;
    }
  }
}