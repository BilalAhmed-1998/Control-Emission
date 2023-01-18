


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressCard extends StatefulWidget {

  double height,width,val;
  Color color,textColor;
  double fontSize;


  CircularProgressCard({Key key,this.width,this.height,this.val,this.textColor}) : super(key: key){

    if(val<=0.5){
      color = Colors.red;
    }
    else if(val>0.5 && val<=0.75){
      color = Colors.amber;

    }
    else if(val>0.75){
      color = Color(0xff3eef85);
    }

    if(height>40){
      fontSize = 12;
    }else{
      fontSize =9;
    }

  }


  @override
  State<CircularProgressCard> createState() => _CircularProgressCardState();
}

class _CircularProgressCardState extends State<CircularProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: widget.val),
              duration: const Duration(milliseconds: 1000),
              builder: (context, value, _) =>
                  CircularProgressIndicator(
                    color: widget.color,
                    backgroundColor: Colors.transparent,
                    value: value,
                    strokeWidth: 4,
                  )),
        ),
        Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: Text(
              '${(widget.val*100).toInt()}%',
              style: TextStyle(
                letterSpacing: 0.5,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize),
            ))
      ],
    );
  }
}
