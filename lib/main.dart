import 'package:control_emission/routes.dart';
import 'package:control_emission/screens/login_page.dart';
import 'package:control_emission/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Control Emission',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'regular'),
        routes: routes,
        home: SplashScreen(
          duration: 2,
          goToPage: LoginPage.routeName,
        ));
  }
}
