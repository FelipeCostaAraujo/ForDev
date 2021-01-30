import 'package:flutter/material.dart';
import 'package:for_dev/main/factories/pages/login/login_page_factory.dart';
import 'package:get/get.dart';
import '../ui/themes/themes.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetMaterialApp(
          title: "4Dev",
          debugShowCheckedModeBanner: false,
          theme: themeDefault(),
          initialRoute: '/login',
          getPages: [
            GetPage(name: '/login', page: makeLoginPage)
          ],
        )
    );
  }
}