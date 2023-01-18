import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/screens/new_trip_map_page.dart';
import 'package:control_emission/screens/trips_page.dart';
import 'package:control_emission/widgets/custom_alert_dialog.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/material.dart';
import '../services/location_service.dart';
import 'circular_progress_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'loading_card.dart';



class VehicleCard extends StatefulWidget {
  Vehicle vehicle;

  VehicleCard({Key key, this.vehicle}) : super(key: key);

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20, bottom: 15),
                  width: 75,
                  height: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/car_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vehicle.company,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.vehicle.registrationNo,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CircularProgressCard(
              width: 32,
              height: 32,
              val: widget.vehicle.totalTrips / 5,
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Total Trips: ${widget.vehicle.totalTrips}',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomAlertDialog(
                                vehicle: widget.vehicle,
                              ));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300,
                        ),
                        alignment: Alignment.center,
                        width: 72,
                        height: 32,
                        child: Text(
                          'More',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                ),
                              ),
                              width: width,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.vehicle.company,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.vehicle.registrationNo,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 18,
                                          height: 1.5,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () async{

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) => LoadingCard(
                                            text: "Fetching location...",
                                          ));

                                      Position currentCoordinates = await LocationService.determinePosition(context);
                                      if (!mounted) return;
                                      if(currentCoordinates!=null ) {


                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NewTripMapPage(
                                                  vehicleDocId: widget.vehicle.docId,
                                                  currentCoordinates: LatLng(currentCoordinates.latitude, currentCoordinates.longitude),
                                                )

                                            ));
                                      }

                                    },
                                    child: SignInButton(
                                      width: width,
                                      height: 56,
                                      text: 'Start New Trip',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TripsPage(
                                                    vehicle: widget.vehicle,
                                                  )));
                                    },
                                    child: SignInButton(
                                      width: width,
                                      height: 56,
                                      text: 'View Previous Trips',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff004040),
                        ),
                        alignment: Alignment.center,
                        width: 70,
                        height: 32,
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: Color(0xffdddddd),
                        )),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
