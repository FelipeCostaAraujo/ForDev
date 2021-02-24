import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/component.dart';
import '../../helpers/helpers.dart';

import './splash.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  SplashPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    R.load(Localizations.localeOf(context));
    final double height = MediaQuery.of(context).size.height * 0.3;
    final double width = MediaQuery.of(context).size.width * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: Text('4dev'),
      ),
      body: Builder(
          builder: (context){
            presenter.navigateToStream.listen((page) {
              if (page?.isNotEmpty == true) {
                Get.offAllNamed(page);
              }
            });
            return Center(
              child: Container(
                height: height,
                width: width,
                child: flareLoading()
              ),
            );
          }
      ),
    );
  }
}