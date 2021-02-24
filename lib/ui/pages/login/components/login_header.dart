import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.3;
    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark
              ]),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 4,
                color: Colors.black),
          ],
          borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(80))),
      child: Image.asset("assets/logo.png", color: Theme.of(context).backgroundColor,),
    );
  }
}