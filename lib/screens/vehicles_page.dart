import 'package:control_emission/cards/auto_vehicle_registration_card.dart';
import 'package:control_emission/cards/vehicle_card.dart';
import 'package:control_emission/classes/Vehicle.dart';
import 'package:control_emission/screens/vehicle_registration_page.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cards/loading_card.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({Key key}) : super(key: key);

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final Stream _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('vehicles')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Vehicles Profile Text///
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.car_fill,
                        color: Colors.grey.shade800,
                        size: 16,
                      ),
                      Text(
                        "  Vehicles' Profiles",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 12,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {

                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return AutoVehicleRegistrationCard();
                          });
                    },
                    child: SignInButton(
                      width: 90,
                      height: 40,
                      text: 'New',
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: _usersStream,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.hasData) {
                  List <QueryDocumentSnapshot> userDocuments = snapshot.data.docs;
                  if (userDocuments.isNotEmpty) {
                    return SizedBox(
                      height: 4*(height/5),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 100),
                          itemCount: userDocuments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return VehicleCard(
                              vehicle: Vehicle(
                                docId: userDocuments[index].id,
                                make: userDocuments[index]['make'],
                                fuelType: userDocuments[index]['fuelType'],
                                co2Km: userDocuments[index]['co2Km'],
                                co2M: userDocuments[index]['co2M'],
                                company: userDocuments[index]['company'],
                                registrationNo: userDocuments[index]
                                    ['vehicleRegistrationNo'],
                                totalTrips: userDocuments[index]
                                    ['vehicleTotalTrips'],
                                yearOfManufacture: userDocuments[index]
                                    ['yearOfManufacture'],
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
                          'No vehicles found!',
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
          ]),
    );
  }
}
