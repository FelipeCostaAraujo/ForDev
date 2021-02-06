import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:for_dev/ui/components/component.dart';
import 'package:get/get.dart';

import './splash.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  SplashPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
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