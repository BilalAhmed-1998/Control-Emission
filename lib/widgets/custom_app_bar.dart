import 'package:flutter/material.dart';

Widget myAppBar(String title) {
  return AppBar(
    backgroundColor: Color(0xff004040),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
