import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomConfirmationDialog extends StatelessWidget {
  String text;
  CustomConfirmationDialog({Key key,this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancel Trip',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
      content: Text(text,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16
        ),),
      actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff004040),
          ),
          child: Text('Yes'),

        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff004040),
          ),
          child: Text('No'),

        ),
      ],


    );
  }
}
