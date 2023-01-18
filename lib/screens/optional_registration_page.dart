import 'package:control_emission/screens/home_page.dart';
import 'package:control_emission/screens/vehicle_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../cards/auto_vehicle_registration_card.dart';

class OptionalRegistrationPage extends StatelessWidget {
  static const routeName = '/OptionalRegistrationPage';

  const OptionalRegistrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, HomePage.routeName);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: Text(
                  'SKIP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              color: Colors.white,
              height: 280,
              width: width,
              child: SvgPicture.asset(
                'assets/images/optional_registration.svg',
                semanticsLabel: 'Register Vehicle',
              ),
            ),
            Container(
              width: width,
              height: 260,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff0A0A0A).withOpacity(0.75),
                    spreadRadius: 0,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Color(0xff004040),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text(
                    'Congrats !',
                    style: TextStyle(
                      height: 2.5,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: Text(
                      'Now you can register your vehicles as many as you want. Start by clicking on button below!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return AutoVehicleRegistrationCard();
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: 152,
                      height: 44,
                      child: Text(
                        'Register Vehicle',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
