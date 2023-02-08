import 'package:control_emission/routes.dart';
import 'package:control_emission/screens/home_page.dart';
import 'package:control_emission/screens/login_page.dart';
import 'package:control_emission/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home:
        SplashScreen(
            duration: 1,
            goToPage: FirebaseAuth.instance.currentUser != null
                ? HomePage.routeName
                : LoginPage.routeName)
    );
  }
}
