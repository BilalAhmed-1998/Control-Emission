import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  int duration = 0;
  String goToPage = "";

  SplashScreen({Key key, this.duration, this.goToPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(
          seconds: duration,
        ), () async {
      Navigator.pushNamed(context, goToPage);
    });

    return Scaffold(
      backgroundColor: const Color(0xff004040),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
