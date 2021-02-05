import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;
  SplashPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return Scaffold(
      appBar: AppBar(
        title: Text('4dev'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SplashPresenterSpy extends Mock implements SplashPresenter{}

abstract class SplashPresenter{
  Future<void> loadCurrentAccount();
}


void main(){

  SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: ()=> SplashPage(presenter:presenter))
          ],
        )
    );
  }

  testWidgets('Should presenter spinner on page load', (WidgetTester tester) async{
    await loadPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (WidgetTester tester) async{
    await loadPage(tester);
    verify(presenter.loadCurrentAccount()).called(1);
  });
}