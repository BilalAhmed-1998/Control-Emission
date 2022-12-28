import 'package:flutter/material.dart';

Widget dashBoardCard(String text,int val) {
  Color color;
  if(text == 'Total Vehicles:'){
    color = Color(0xff0A0150);
  }else if(text == 'Total Trips:'){
    color = Color(0xff562FBE);
  }
  return Container(
    width: 150,
    height: 140,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(val.toString(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),),
        Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),),


      ],
    ),
  );
}


