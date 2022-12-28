import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/screens/trips_page.dart';
import 'package:control_emission/widgets/custom_alert_dialog.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circular_progress_card.dart';

class VehicleCard extends StatelessWidget {
  Vehicle vehicle;

  VehicleCard({Key key, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                      vehicle.company,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      vehicle.registrationNo,
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
              val: vehicle.totalTrips / 5,
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Total Trips: ${vehicle.totalTrips}',
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
                                vehicle: vehicle,
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
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
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
                                        vehicle.company,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        vehicle.registrationNo,
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
                                    onTap: () {},
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TripsPage(
                                                    vehicle: vehicle,
                                                  )));
                                    },
                                    child: SignInButton(
                                      width: width,
                                      height: 56,
                                      text: 'View Previous Trips',
                                    ),
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
