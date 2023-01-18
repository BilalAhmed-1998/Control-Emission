import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VehiclesDashboardCard extends StatefulWidget {
  String text, docName;
  Color color;
  VehiclesDashboardCard({Key key, this.text}) : super(key: key) {
    if (text == 'Total Vehicles:') {
      docName = 'totalVehicles';
      color = Color(0xff0A0150);
    } else if (text == 'Total Trips:') {
      docName = 'totalTrips';
      color = Color(0xff562FBE);
    }
  }

  @override
  State<VehiclesDashboardCard> createState() => _VehiclesDashboardCardState();
}

class _VehiclesDashboardCardState extends State<VehiclesDashboardCard> {
  final Stream _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.hasData) {
          var userDocument = snapshot.data;
          return Container(
            height: 140,
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  userDocument[widget.docName].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

