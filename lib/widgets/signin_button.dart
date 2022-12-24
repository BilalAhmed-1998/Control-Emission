import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  String text;
  double height, width;
  SignInButton({Key key, this.width, this.height, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff004040),
      ),
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
