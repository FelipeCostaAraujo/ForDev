import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    appdata.writeIfNull('darkmode', false);

    return SimpleBuilder(
        builder: (_){
          bool isDarkMode = appdata.read('darkmode');

          return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                  Text(Localizations.localeOf(context).toString()),
                    Text("Essa e a home"),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value){
                        Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                        setState(() {
                          print(value);
                          appdata.write('darkmode', value);
                          isDarkMode = value;
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }) ;
  }
}
