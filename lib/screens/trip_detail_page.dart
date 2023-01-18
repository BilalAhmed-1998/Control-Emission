import 'dart:math';

import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/classes/trip.dart';
import 'package:control_emission/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../cards/circular_progress_card.dart';

class TripDetailPage extends StatefulWidget {
  Trip trip;
  Vehicle vehicle;
  TripDetailPage({Key key, this.trip, this.vehicle}) : super(key: key);

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar(''),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Trip Starting Date Time///
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: Color(0xff004040),
                ),
                Text(
                  "  ${DateFormat.yMMMEd().format(widget.trip.startingTime)}, ${DateFormat.jm().format(widget.trip.startingTime)} ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),

            ///Second row///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 23),
              child: Row(
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
                            size: 20,
                          ),
                          Text(
                            '  ${widget.trip.startingAddress}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff004040),
                              fontSize: 22,
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
                              size: 20,
                            ),
                          ),
                          Text(
                            '    ',
                            style: TextStyle(
                              color: Color(0xff004040),
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff004040),
                            size: 25,
                          ),
                          Text(
                            '  ${widget.trip.endingAddress}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff004040),
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  CircularProgressCard(
                    width: 45,
                    height: 45,
                    val: widget.vehicle.totalTrips / 5,
                    textColor: Colors.grey.shade600,
                  )
                ],
              ),
            ),

            ///Google Map Routes Container///
            Container(
             // height: 3 * (height / 5),
              width: width,
              margin: EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff004040), width: 1)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/map 1.png'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                    decoration: BoxDecoration(
                        color: Color(0xff004040),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(9.0),
                          bottomRight: Radius.circular(9.0),
                        )),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.vehicle.company,
                              style: TextStyle(
                                  color: Color(0xffdddddd),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Vehicle',
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
                          children: [
                            Text(
                              widget.trip.duration,
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
                          children: [
                            Text(
                              '${widget.trip.distance} km',
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
                ],
              ),
            ),

            ///Trip Ending Date Time///
            Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 14,
                  color: Color(0xff004040),
                ),
                Text(
                  "  ${DateFormat.yMMMEd().format(widget.trip.endingTime)}, ${DateFormat.jm().format(widget.trip.startingTime)} ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
