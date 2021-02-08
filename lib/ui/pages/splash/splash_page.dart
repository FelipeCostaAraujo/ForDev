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
                height: 200,
                width: 200,
                child: flareLoading()
              ),
            );
          }
      ),
    );
  }
}