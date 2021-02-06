import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './factories/factories.dart';
import '../ui/themes/themes.dart';

void main() async{
  await DotEnv.load(fileName: ".env");
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetMaterialApp(
          title: "4Dev",
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
            GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
            GetPage(name: '/home', page: () => Scaffold(body: Text("Essa e a home"),) , transition: Transition.fadeIn)
          ],
        )
    );
  }
}