import 'package:flutter/material.dart';

import '../themes/themes.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "4Dev",
        debugShowCheckedModeBanner: false,
        home: LoginPage(null),
        theme: themeDefault(),
      )
    );
  }
}
