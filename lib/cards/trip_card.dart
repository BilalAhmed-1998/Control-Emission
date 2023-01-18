import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circular_progress_card.dart';
import 'package:intl/intl.dart';

class TripCard extends StatelessWidget {

  String startingAddress,endingAddress,carName,duration,registrationNo,fuelType;
  double distance;
  DateTime dateTime;
  int circularProgressVal;

  TripCard({Key key,this.dateTime,this.duration,this.circularProgressVal,this.carName,this.distance,this.endingAddress,this.fuelType,this.registrationNo,this.startingAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff6C6C6C).withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///first row///
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_circle_fill,
                        color: Color(0xff004040),
                        size: 12,
                      ),
                      Text(
                        '  $startingAddress',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Transform.rotate(
                        angle: 90 * pi / 180,
                        child: Icon(
                          Icons.linear_scale,
                          color: Color(0xff004040),
                          size: 12,
                        ),
                      ),
                      Text(
                        '    ',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xff004040),
                        size: 13,
                      ),
                      Text(
                        '  $endingAddress',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              CircularProgressCard(
                width: 32,
                height: 32,
                val: circularProgressVal/5,
                textColor: Colors.grey.shade600,
              )
            ],
          ),

          ///Second row///
          Container(
            margin: EdgeInsets.symmetric(vertical: 17),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xff004040),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children:  [
                    Text(
                      carName,
                      style: TextStyle(
                          color: Color(0xffdddddd),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Car',
                      style: TextStyle(
                          color: Color(0xffdddddd),
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                    ),
                  ],
                ),
                Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Icon(
                    Icons.linear_scale,
                    color: Color(0xffdddddd),
                    size: 25,
                  ),
                ),
                Column(
                  children:  [
                    Text(
                      duration,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Color(0xffdddddd),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(
                          color: Color(0xffdddddd),
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                    ),
                  ],
                ),
                Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Icon(
                    Icons.linear_scale,
                    color: Color(0xffdddddd),
                    size: 25,
                  ),
                ),
                Column(
                  children:  [
                    Text(
                      '${distance.toStringAsFixed(1)} km',
                      style: TextStyle(
                          color: Color(0xffdddddd),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total Distance',
                      style: TextStyle(
                          color: Color(0xffdddddd),
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///Last row///
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.amber,
                size: 12,
              ),
              Text(
                '  Registration No: $registrationNo',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12,
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.deepOrange,
                size: 12,
              ),
              Text(
                '  Fuel Type : $fuelType',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 12, height: 2),
              )
            ],
          ),

          ///Date Time///
          Text(
            "  ${DateFormat.yMMMEd().format(dateTime)}, ${DateFormat.jm().format(dateTime)} "  ,
            textAlign: TextAlign.start,
            style:
                TextStyle(color: Colors.grey.shade600, fontSize: 8, height: 4),
          )
        ],
      ),
    );
  }
}
