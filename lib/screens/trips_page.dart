import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/classes/trip.dart';
import 'package:control_emission/screens/trip_detail_page.dart';
import 'package:control_emission/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    double height = MediaQuery.of(context).size.height;
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


            ///Stream Builder for Trips fetching ///

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('vehicles')
                  .doc(widget.vehicle.docId)
                  .collection('trips')
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.hasData) {
                  List <QueryDocumentSnapshot> userDocuments = snapshot.data.docs;
                  if (userDocuments.isNotEmpty) {
                    return SizedBox(
                      height: height,
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 200),
                          itemCount: userDocuments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TripDetailPage(
                                          vehicle: widget.vehicle,
                                          trip: Trip(
                                            startingTime: userDocuments[index]['startingTime'].toDate(),
                                            endingTime: userDocuments[index]['endingTime'].toDate(),
                                            startingAddress: userDocuments[index]['startingAddress'],
                                            endingAddress: userDocuments[index]['endingAddress'],
                                            startingCoordinates: LatLng(userDocuments[index]['startingCoordinates'].latitude, userDocuments[index]['startingCoordinates'].longitude),
                                            endingCoordinates: LatLng(userDocuments[index]['endingCoordinates'].latitude, userDocuments[index]['startingCoordinates'].longitude),
                                            distance: userDocuments[index]['distance'],
                                            duration: userDocuments[index]['duration'],
                                            encodedPoints: userDocuments[index]['encodedPoints'],
                                          ),
                                        )));


                              },
                              child: TripCard(
                                startingAddress: userDocuments[index]['startingAddress'],
                                endingAddress: userDocuments[index]['endingAddress'],
                                carName: widget.vehicle.make,
                                duration: userDocuments[index]['duration'],
                                distance: userDocuments[index]['distance'],
                                registrationNo: widget.vehicle.registrationNo,
                                fuelType: widget.vehicle.fuelType,
                                circularProgressVal: widget.vehicle.totalTrips,
                                dateTime: userDocuments[index]['endingTime'].toDate(),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container(
                        height: height/2,
                        width: width,
                        alignment: Alignment.center,
                        child: Text(
                          'No Trips found!',
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ));
                  }
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        )));
  }
}
