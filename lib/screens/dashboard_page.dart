import 'package:control_emission/cards/dash_board_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cards/circular_progress_card.dart';
import '../cards/trip_card.dart';
import '../cards/vehicle_card.dart';
import '../data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);


  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///APPBAR ATTACHED CONTAINER///
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff0A0A0A).withOpacity(0.35),
                  spreadRadius: 0,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
              color: Color(0xff004040),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(22),
                  bottomLeft: Radius.circular(22)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Bilal',
                  style: TextStyle(
                    color: Color(0xffdddddd),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Check your vehicles' Trip Performance ",
                          style: TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 20,
                          color: Color(0xffdddddd),
                        ),
                      ],
                    ),

                    ///tween builder///
                    CircularProgressCard(
                      width: 32,
                      height: 32,
                      val: 0.8,
                      textColor: Color(0xffdddddd),
                    )
                  ],
                ),
              ],
            ),
          ),
          /// MAIN DASHBOARD PARTS///
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              'DASHBOARD',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dashBoardCard('Total Vehicles:', 04),
                dashBoardCard('Total Trips:', 10),
              ],
            ),
          ),

          /// Recent Activities///
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              'RECENT TRIP',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TripCard(
            startingAddress: 'Islamabad',
            endingAddress: 'Taxila',
            carName: 'Aqua',
            duration: '1h 32m',
            distance: '110',
            registrationNo: 'VEI5VLH',
            fuelType: 'Electric',
            circularProgressVal: 1,
            dateTime: DateTime.now(),
          ),

          /// Recent Activities///
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              'RECENT VEHICLE',
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
          ),
          VehicleCard(
          vehicle: vehicles.last,
          ),

        ],
      ),
    );
  }
}
