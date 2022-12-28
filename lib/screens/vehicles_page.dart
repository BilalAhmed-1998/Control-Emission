import 'package:control_emission/cards/vehicle_card.dart';
import 'package:control_emission/data.dart';
import 'package:control_emission/screens/vehicle_registration_page.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({Key key}) : super(key: key);

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Vehicles Profile Text///
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    onTap: (){
                      Navigator.pushNamed(context, VehicleRegistrationPage.routeName);
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

            /// Vehicle Cards ///
            SizedBox(
              height: 700,
              child: ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VehicleCard(
                    vehicle: vehicles[index],
                    );
                  }),
            ),
          ]),
    );
  }
}
