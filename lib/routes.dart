import 'package:control_emission/screens/home_page.dart';
import 'package:control_emission/screens/login_page.dart';
import 'package:control_emission/screens/optional_registration_page.dart';
import 'package:control_emission/screens/signup_page.dart';
import 'package:control_emission/screens/vehicle_registration_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => HomePage(),
  LoginPage.routeName: (context) => LoginPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  VehicleRegistrationPage.routeName: (context) => VehicleRegistrationPage(),
  OptionalRegistrationPage.routeName: (context) => OptionalRegistrationPage(),
};
