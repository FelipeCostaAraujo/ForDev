import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter/material.dart';
import 'package:for_dev/ui/pages/home/home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './factories/factories.dart';
import '../ui/themes/themes.dart';

void main() async{
  await DotEnv.load(fileName: ".env");
  await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {

  final appdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    appdata.writeIfNull('darkmode', false);
    bool isDarkMode = appdata.read('darkmode');
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);

    return Container(
        child: GetMaterialApp(
          title: "4Dev",
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
            GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
            GetPage(name: '/home', page: () => HomePage(), transition: Transition.fadeIn)
          ],
        )
    );;
  }
}



// Scaffold(
// body: Center(
// child: Column(
// children: [
// SizedBox(
// height: 40,
// ),
// Text("Essa e a home"),
// ],
// ),
// )
// )