import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/data.dart';
import 'package:control_emission/screens/trip_detail_page.dart';
import 'package:flutter/material.dart';

import '../cards/trip_card.dart';
import '../widgets/custom_app_bar.dart';

class TripsPage extends StatefulWidget {
  Vehicle vehicle;

  TripsPage({Key key, this.vehicle}) : super(key: key);

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: myAppBar("${widget.vehicle.make} Trips"),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// MAIN DASHBOARD PARTS///
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                ' PREVIOUS TRIPS',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 12,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripDetailPage(
                          vehicle: widget.vehicle,
                          trip: trips[0],
                        )));


              },
              child: TripCard(
                startingAddress: 'Islamabad',
                endingAddress: 'Taxila',
                carName: widget.vehicle.make,
                duration: '1h 32m',
                distance: '110',
                registrationNo: widget.vehicle.registrationNo,
                fuelType: widget.vehicle.fuelType,
                circularProgressVal: widget.vehicle.totalTrips,
                dateTime: DateTime.now(),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripDetailPage(
                          vehicle: widget.vehicle,
                          trip: trips[0],
                        )));


              },
              child: TripCard(
                startingAddress: 'Islamabad',
                endingAddress: 'Taxila',
                carName: widget.vehicle.make,
                duration: '1h 32m',
                distance: '110',
                registrationNo: widget.vehicle.registrationNo,
                fuelType: widget.vehicle.fuelType,
                circularProgressVal: widget.vehicle.totalTrips,
                dateTime: DateTime.now(),
              ),
            ),
          ],
        )));
  }
}
