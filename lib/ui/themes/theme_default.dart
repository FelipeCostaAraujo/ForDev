import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const brightness = Brightness.light;
const primaryColor = Color.fromRGBO(136, 14, 76, 1);
const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
const backgroundColor = const Color(0xFFFFFFFF);

ThemeData themeDefault() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  return ThemeData(
    brightness: brightness,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColorLight)
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor)
      ),
      alignLabelWithHint: true
    ),
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    backgroundColor: backgroundColor,
    accentColor: primaryColor,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: primaryColorDark
      )
    ),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light(primary: primaryColor),
      buttonColor: primaryColor,
      splashColor: primaryColorLight,
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      )
    )
    //fontFamily: 'Montserrat',
  );
}
